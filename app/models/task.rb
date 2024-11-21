class Task < ApplicationRecord
  include PublicActivity::Model 
  tracked owner: proc {|controller, _model| controller.current_user }

  belongs_to :sprint
  belongs_to :created_by, class_name: 'User'
  # belongs_to :assigned_to, class_name: 'User', optional: true 
  has_and_belongs_to_many :users 

  after_create_commit :notify_recipient 
  before_destroy :cleanup_notifications 
  has_noticed_notifications model_name: 'Noticed::Event'
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'

  validates :name, presence: true
  # validates :desciption, presence: true

  before_create :set_default_status
  broadcasts_to ->(task) { [task.created_by.tenant_employees.first.tenant, task.sprint, "tasks"]}, inserts_by: :append 

  private 

  def set_default_status
      self.status ||= "pending" 
  end 

  def notify_recipient 
    TaskNotifier.with(record: self, sprint:).deliver_later(sprint.user)
    ActionCable.server.broadcast("notification_channel", {
      title: name,
      body: "<b>#{created_by.full_name}</b> has added <b>#{name}</b> task to the <b>#{sprint.name}</b>"
    })
  end 

  def cleanup_notifications
    sprint.notifications.where(id: sprint.id).destroy_all
  end 
end

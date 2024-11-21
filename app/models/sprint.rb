class Sprint < ApplicationRecord
  include PublicActivity::Model 
  tracked owner: proc {|controller, _model| controller.current_user }
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :name, presence: true 

  has_many :notifications, through: :user, dependent: :destroy 
  has_many :notification_mentions, through: :user, dependent: :destroy
  has_noticed_notifications model_name: 'Noticed::Notification'

  broadcasts_to -> (sprint) { [sprint.user.tenant_employees.first.tenant, "sprints"]}, inserts_by: :append
end

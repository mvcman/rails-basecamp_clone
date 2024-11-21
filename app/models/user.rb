class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile
  has_many :tenants
  has_many :sprints 
  has_many :standups 
  has_many :templates
  has_and_belongs_to_many :tasks
  has_many :tenant_employees

  validates :time_zone, presence: true 

  has_many :notifications, as: :recipient, dependent: :destroy, class_name: 'Noticed::Notification' 
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'

  def full_name 
    profile.first_name + " " + profile.last_name 
  end 

  def self.search(params)
    where('email LIKE ?', "%#{params[:q]}%")
  end 
end

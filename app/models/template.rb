class Template < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy

  scope :ordered, -> { order(:created_at) }
end

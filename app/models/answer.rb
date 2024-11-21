class Answer < ApplicationRecord
  belongs_to :standup
  belongs_to :question
end

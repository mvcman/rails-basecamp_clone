class Question < ApplicationRecord
  belongs_to :template
  has_many :answers, dependent: :destroy 

  enum question_type: { boolean: 'boolean', text: 'text', select: 'select', task: 'task', previous_answer: 'previous_answer' }

  serialize :options, Array 
end

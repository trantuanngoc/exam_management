class Question < ApplicationRecord
  has_many :exam_questions
  has_many :exams, through: :exam_questions
  has_many :answers
  has_one :right_answer, class_name: Answer.name, foreign_key: :right_answer
end

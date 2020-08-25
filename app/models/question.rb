class Question < ApplicationRecord
  has_many :exam_questions
  has_many :exams, through: :exam_questions
  has_many :answers
  belongs_to :answer, class_name: :Answer, foreign_key: :answer_id, primary_key: :right_answer_id, dependent: :destroy
end

class Exam < ApplicationRecord
  has_many :user_exams
  has_many :users, through: :user_exams
  belongs_to :subject
  has_many :exam_questions
  has_many :questions, through: :exam_questions
end

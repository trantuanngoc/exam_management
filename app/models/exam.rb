class Exam < ApplicationRecord
  has_many :user_exams
  has_many :users, through: :user_exams
  has_many :exam_questions
  has_many :questions, through: :user_exams
end

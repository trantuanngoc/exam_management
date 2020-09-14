class Question < ApplicationRecord
  has_many :exam_questions
  has_many :exams, through: :exam_questions
  has_many :answers

  accepts_nested_attributes_for :answers
<<<<<<< Updated upstream
  accepts_nested_attributes_for :exam_questions
=======
>>>>>>> Stashed changes
end

class Exam < ApplicationRecord
  has_many :user_exams
  has_many :users, through: :user_exams
  belongs_to :subject
  has_many :questions, dependent: :destroy

  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
end

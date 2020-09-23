class UserExam < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  has_many :take_answers

  accepts_nested_attributes_for :take_answers, reject_if: :all_blank, allow_destroy: true
end

class Exam < ApplicationRecord
  has_many :user_exams
  has_many :users, through: :user_exams
  belongs_to :subject
  has_many :questions, dependent: :destroy
  validates :name, presence: true

  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
  validate :require_one_question

  private
    def require_one_question
      errors.add(:base, "You must provide at least one questions") if questions.size < 1
    end
end

class Question < ApplicationRecord
  validates :content, presence: true
  belongs_to :exam
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  validate :require_two_answers

  private
    def require_two_answers
      errors.add(:base, "You must provide at least two answers") if answers.size < 2
    end
end

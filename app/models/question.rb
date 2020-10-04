class Question < ApplicationRecord
  validates :content, presence: true
  belongs_to :exam
  has_many :answers, dependent: :destroy
  has_one :take_answer, dependent: :destroy


  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  validate :require_two_answers, :require_one_correct_answer

  private

  def require_one_correct_answer
    errors.add(:base, "You have to add 1 correct answer") unless answers.reject(&:marked_for_destruction?).any? { |a| a[:correct] == true }
  end

  def require_two_answers
    errors.add(:base, "You must provide at least two answers") if answers.reject(&:marked_for_destruction?).size < 2
  end
end

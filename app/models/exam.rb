class Exam < ApplicationRecord
  validates :name, presence: true
  enum status: [:draft, :public], _prefix: :exams
  has_many :user_exams
  has_many :users, through: :user_exams
  has_many :questions, dependent: :destroy
  belongs_to :subject

  accepts_nested_attributes_for :questions, allow_destroy: true
  validate :require_one_question

  private

  def require_one_question
    errors.add(:base, "You must provide at least one questions") if questions.reject(&:marked_for_destruction?).size < 1
  end
end

class Exam < ApplicationRecord
  validates :name, presence: true
  has_many :user_exams
  has_many :users, through: :user_exams
  has_many :questions, dependent: :destroy
  belongs_to :subject

  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
  validate :require_one_question

  def public?
    true if self.status == "public"
  end

  def draft?
    true if self.status == "draft"
  end

  private

  def require_one_question
    errors.add(:base, "You must provide at least one questions") if questions.size < 1
  end
end

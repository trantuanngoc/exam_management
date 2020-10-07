class UserExam < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  has_many :take_answers
  after_update :calculate_score, if: Proc.new { |user_exam| !user_exam.score && user_exam.done? }

  accepts_nested_attributes_for :take_answers, reject_if: :all_blank, allow_destroy: true

  private

  def calculate_score
    diem = TakeAnswer.joins(:answer).where(user_exam_id: self.id, answers: {correct: true}).size
    diem = (diem.to_f / exam.questions.count.to_f) * 100
    self.score = diem
    save
  end
end

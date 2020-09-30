class UserExam < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  has_many :take_answers
  after_update :calculate_score, unless: Proc.new { |user_exam| user_exam.score }

  accepts_nested_attributes_for :take_answers, reject_if: :all_blank, allow_destroy: true

  private

  def calculate_score
    diem = 0
    take_answers.find_each do |take_answer|
      diem +=1 if take_answer.answer.correct?
    end
    diem = (diem.to_f / exam.questions.count.to_f) * 100
    self.score = diem
    save
  end
end

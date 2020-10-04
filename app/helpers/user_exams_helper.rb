module UserExamsHelper
  def check_if_chosen?(user_exam, answer)
    !!TakeAnswer.find_by(user_exam_id: user_exam.id, answer_id: answer.id)
  end
end

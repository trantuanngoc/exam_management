class UserExamWorker
  include Sidekiq::Worker

  def perform user_exam_id
    user_exam = UserExam.find_by_id user_exam_id
    return unless user_exam
    destroy_jobs user_exam_id
    user_exam.update_attributes(score: 0) unless user_exam.score
  end

  def destroy_jobs user_exam_id
    jobs = Sidekiq::ScheduledSet.new.select do |retri|
      retri.klass == self.class.name && retri.item["args"] == [user_exam_id]
    end
    jobs.each(&:delete)
  end
end

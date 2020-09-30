class UserExamWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform user_exam_id
    @user_exam = UserExam.find_by(id: user_exam_id)
    destroy_jobs user_exam_id
    unless @user_exam.done?
      @user_exam.update_attributes(score: 0, done: true)
    end
  end

  def destroy_jobs user_exam_id
    jobs = Sidekiq::ScheduledSet.new.select do |retri|
      retri.klass == self.class.name && retri.item["args"] == [user_exam_id]
    end
    jobs.each(&:delete)
  end
end

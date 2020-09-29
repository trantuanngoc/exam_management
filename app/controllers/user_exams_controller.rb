class UserExamsController < ApplicationController
  before_action :get_done_exam, only: [:index]

  def index; end

  def new
    @exam = Exam.find_by(id: params[:exam_id])
    @user_exam = UserExam.new
    @user_exam.take_answers.build
  end

  def create
    @user_exam = UserExam.new(user_exam_params)
    UserExamWorker.perform_at(Time.zone.now + 30.minutes, @user_exam.id)
    if @user_exam.save
      flash[:success] = "Create sucessful"
      redirect_to user_exams_path
    else
      flash[:info] = "Created failed!"
      render :new
    end
  end

  private

  def user_exam_params
    params.require(:user_exam).permit(
      :user_id, :exam_id, :user_id, take_answers_attributes: [:id, :answer_id, :_destroy]
    )
  end

  def get_done_exam
    if current_user.admin?
      @user_exams = UserExam.paginate(page: params[:page])
    else
      @user_exams = UserExam.where(user_id: current_user.id).paginate(page: params[:page])
    end
  end
end

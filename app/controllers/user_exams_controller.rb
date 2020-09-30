class UserExamsController < ApplicationController
  before_action :get_done_exam, only: [:index]
  before_action :redirect_if_time_out, only: [:update]

  def index; end

  def new
    @exam = Exam.find_by(id: params[:exam_id])
    @user_exam = UserExam.create(exam_id: @exam.id, user_id: current_user.id)
    @user_exam.take_answers.build
    UserExamWorker.perform_at(Time.zone.now + 30.minutes, @user_exam.id)
  end

  def update
    if @user_exam.update(user_exam_params)
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
      take_answers_attributes: [:id, :answer_id, :_destroy]
    )
  end

  def get_done_exam
    if current_user.admin?
      @user_exams = UserExam.paginate(page: params[:page])
    else
      @user_exams = UserExam.where(user_id: current_user.id).paginate(page: params[:page])
    end
  end

  def redirect_if_time_out
    @user_exam = UserExam.find_by(id: params[:id])
    flash[:danger] = "Time out"
    redirect_to user_exams_path if @user_exam.score
  end
end

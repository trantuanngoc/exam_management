class UserExamsController < ApplicationController
  before_action :get_done_exam, only: [:index]
  before_action :redirect_if_time_out, only: [:update]
  before_action :redirect_if_not_done, only: [:show]

  def index; end

  def show; end

  def new
    @exam = Exam.find_by(id: params[:exam_id])
    @user_exam = UserExam.find_or_initialize_by(exam_id: @exam.id, user_id: current_user.id, done: false)
    if @user_exam.new_record?
      @user_exam.update(start_at: Time.zone.now, end_at: Time.zone.now + 30.minutes)
    else
      @time = @user_exam.end_at.to_f * 1000
    end
    @user_exam.take_answers.build
    UserExamWorker.perform_at(Time.zone.now + 30.minutes, @user_exam.id)
  end

  def save
    @user_exam = UserExam.find_by(id: params[:user_exam_id])
    @question = Answer.find_by(id: params[:answer_id]).question
    TakeAnswer.where(question_id: @question.id, user_exam_id: @user_exam.id).delete_all
    TakeAnswer.create(user_exam_id: @user_exam.id, answer_id: params[:answer_id], question_id: @question.id)
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
    params
      .require(:user_exam)
      .permit(:done)
      .with_defaults(done: true)
  end

  def get_done_exam
    if current_user.admin?
      @user_exams = UserExam.order(:score).paginate(page: params[:page])
    else
      @user_exams = UserExam.where(user_id: current_user.id).order(:score).paginate(page: params[:page])
    end
  end

  def redirect_if_time_out
    @user_exam = UserExam.find_by(id: params[:id])
    if Time.zone.now > @user_exam.end_at
      flash[:danger] = "Time out"
      redirect_to user_exams_path
    end
  end

  def redirect_if_not_done
    @user_exam = UserExam.find_by(id: params[:id])
    redirect_to user_exams_path unless @user_exam.done?
  end
end

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
    if @user_exam.save
      calculate_score
      @user_exam.update(score: @score)
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

  def calculate_score
    @score = 0
    @user_exam.take_answers.find_each do |take_answer|
      @score+=1 if take_answer.answer.correct?
    end
    @score = (@score.to_f / @user_exam.exam.questions.count.to_f)*100
  end

  def get_done_exam
    if current_user.admin?
      @user_exams = UserExam.paginate(page: params[:page])
    else
      @user_exams = UserExam.where(user_id: current_user.id).paginate(page: params[:page])
    end
  end
end

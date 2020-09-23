class UserExamsController < ApplicationController
  def new
    @exam = Exam.find_by(id: params[:exam_id])
    @user_exam = UserExam.new
    @user_exam.take_answers.build
  end

  def create
    @user_exam = UserExam.new(user_exam_params)
    if @user_exam.save
      flash[:success] = "Create sucessful"
      redirect_to exams_path
    else
      flash[:info] = "Created failed!"
      render :new
    end
  end

  private

  def user_exam_params
    params.require(:user_exam).permit(
      :user_id, :exam_id, take_answers_attributes: [:id, :answer_id, :_destroy]
    )
  end
end

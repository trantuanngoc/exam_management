class ExamsController < ApplicationController
  before_action :find_exam, only: [:show, :edit, :destroy, :update]
  before_action :redirect_if_not_admin
  def index
    @exams = Exam.paginate(page: params[:page])
  end

  def new; end

  def show; end

  def create
    @subject = Subject.find_by(name: params[:exam][:subject_name])
    @exam = @subject.exams.create(name: params[:exam][:name], subject_id: params[:exam][:subject_id], status: params[:exam][:status])
    if @exam.save
      flash[:success] = "Create sucessful"
      redirect_to exams_path
    else
      render :edit
    end
  end

  def edit; end

  def update
    if @exam.update(exam_params)
      flash[:success] = "exam updated"
      redirect_to exams_path
    else
      render :edit
    end
  end

  def destroy
    @exam.destroy
    flash[:success] = "exam deleted"
    redirect_to exams_path
  end

  private

  def exam_params
    params.require(:exam).permit(:name, :subject_name)
  end

  def find_exam
    @exam = Exam.find_by(id: params[:id])
  end
end

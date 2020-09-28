class ExamsController < ApplicationController
  before_action :find_exam, only: [:edit, :destroy, :update]
  before_action :redirect_if_not_admin
  before_action :list_subjects, only: %i(new edit create)
  before_action :redirect_if_edit_public, only: :edit

  def index
    @exams = Exam.paginate(page: params[:page])
  end

  def new
    @exam = Exam.new
    @exam.questions.build.answers.build unless @exam.questions.build.answers.build.present?
  end

  def create
    @exam = Exam.new(exam_params)
    if @exam.save
      flash[:success] = "Create sucessful"
      redirect_to exams_path
    else
      flash[:info] = "Created failed!"
      render :new
    end
  end

  def edit; end

  def update
    if @exam.update(exam_params)
      flash[:success] = "Exam updated"
      redirect_to exams_path
    else
      render :edit
    end
  end

  def destroy
    @exam.destroy
    flash[:success] = "Exam deleted"
    redirect_to exams_path
  end

  private

  def exam_params
    params.require(:exam).permit(
      :name, :subject_id, :status, questions_attributes: [:id, :content, :_destroy, answers_attributes: [:id, :content, :correct, :_destroy]]
    )
  end

  def list_subjects
    @subjects = Subject.all.map{ |subject| [subject.name, subject.id] }
  end

  def redirect_if_edit_public
    if @exam.exams_public?
      flash[:info] = "Can't edit public exam"
      redirect_to exams_path
    end
  end

  def find_exam
    @exam = Exam.find(params[:id])
  end
end

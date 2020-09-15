class ExamsController < ApplicationController
  before_action :find_exam, only: [:show, :edit, :destroy, :update]
  before_action :redirect_if_not_admin
  before_action :list_questions, :list_subjects, only: %i(new edit)
  def index
    @exams = Exam.paginate(page: params[:page])
  end

  def new
    @exam = Exam.new
  end

  def show; end

  def create
    @exam = Exam.new(exam_params)
    if @exam.save
      flash[:success] = "Created success!"
      redirect_to exams_path
    else
      flash[:error] = "Created failed!"
      render :new
    end
  end

  def edit; end

  def update
    if @exam.update(exam_params)
      flash[:success] = "Exam updated"
      redirect_to exam_path
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
      :name, :subject_id, :status, question_ids: [], exam_questions_attributes: [:id, :question_id, :exam_id]
    )
  end

  def list_subjects
    @subjects = Subject.all.select(:id, :name).map{|subject| [subject.name, subject.id]}
  end

  def list_questions
    @questions = Question.all.select(:id, :content).map{|question| [question.content, question.id]}
  end

  def find_exam
    @exam = Exam.find_by(id: params[:id])
  end
end

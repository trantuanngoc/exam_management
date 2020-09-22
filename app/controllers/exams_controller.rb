class ExamsController < ApplicationController
  before_action :find_exam, only: [:edit, :destroy, :update]
  before_action :redirect_if_not_admin
  before_action :list_subjects, only: %i(new edit)
  before_action :redirect_if_edit_public, only: :edit

  def index
    @exams = Exam.paginate(page: params[:page])
  end

  def new
    @exam = Exam.new
    @exam.questions.build.answers.build unless @exam.questions.build.answers.build.present?
  end

  def create
    @exam = Exam.create(exam_params)
    if @exam.save
      flash[:success] = "Created success!"
      redirect_to :edit
    else
      @subjects = Subject.all.map{ |subject| [subject.name, subject.id] }
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
      :name, :subject_id, :status, questions_attributes: [:id, :content, answers_attributes: [:id, :content, :correct]]
    )
  end

  def list_subjects
    @subjects = Subject.all.map{ |subject| [ subject.name, subject.id ] }
  end

  def redirect_if_edit_public
    if @exam.status == 'public'
      flash[:infor] = "Can't edit public exam"
      redirect_to exams_path
    end
  end

  def find_exam
    @exam = Exam.find_by(id: params[:id])
  end
end

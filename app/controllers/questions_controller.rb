class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :destroy, :update]
  before_action :redirect_if_not_admin
  def index
    @questions = Question.paginate(page: params[:page])
  end

  def new
    @question = Question.new
  end

  def show; end

  def create
    @subject = Subject.find_by(name: params[:question][:subject_name])
    @question = @subject.questions.create(name: params[:question][:name], subject_id: params[:question][:subject_id], status: params[:question][:status])
    if @question.save
      flash[:success] = "Create sucessful"
      redirect_to questions_path
    else
      render :edit
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      flash[:success] = "question updated"
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:success] = "question deleted"
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:name, :subject_name)
  end

  def find_question
    @question = Question.find_by(id: params[:id])
  end
end

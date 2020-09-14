class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :destroy, :update]
  before_action :redirect_if_not_admin
  def index
    @questions = Question.paginate(page: params[:page])
  end

  def new
    @question = Question.new
    @question.answers.build unless @question.answers.build.present?
  end

  def show; end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = "Created success!"
      redirect_to root_path
    else
      flash[:error] = "Created failed!"
      render :new
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
    params.require(:question).permit(
      :content, :right_answer, answers_attributes: [:content]
    )
  end

  def find_question
    @question = Question.find_by(id: params[:id])
  end
end

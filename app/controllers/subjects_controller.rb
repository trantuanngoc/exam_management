class SubjectsController < ApplicationController
  before_action :find_subject, only: [:show, :edit, :destroy, :update]
  before_action :redirect_if_not_admin

  def index
    @subjects = Subject.paginate(page: params[:page])

    unless Subject.order(:name).where("name like ?", "%#{params[:term]}%").empty?
      @hints = Subject.order(:name).where("name like ?", "%#{params[:term]}%")
    else
      @hints = Subject.order(:name)
    end
    respond_to do |format|
      format.html
      format.json { render json: @hints.map(&:name) }
    end
  end

  def new
    @subject = Subject.new
  end

  def show; end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:success] = "Create sucessful"
      redirect_to subjects_path
    else
      render :edit
    end
  end

  def edit; end

  def update
    if @subject.update(subject_params)
      flash[:success] = "Subject updated"
      redirect_to subjects_path
    else
      render :edit
    end
  end

  def destroy
    @subject.destroy
    flash[:success] = "Subject deleted"
    redirect_to subjects_path
  end

  private

  def subject_params
    params.require(:subject).permit(:name)
  end

  def find_subject
    @subject = Subject.find_by(id: params[:id])
  end
end

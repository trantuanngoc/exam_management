class ProfilesController < ApplicationController
  before_action :find_user_and_profile, only: [:show, :edit, :update]

  def show; end

  def edit; end

  def update
    if @profile.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_profile_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:profile).permit(:first_name, :last_name, :address, :email, :password, :password_confirmation)
  end

  def find_user_and_profile
    @user = User.find_by(id: params[:user_id])
    @profile = @user.profile
  end
end

class ProfilesController < ApplicationController
  def show
    @user = User.find_by(id: params[:user_id])
    @profile = @user.profile
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @profile = @user.profile
  end

  def update
    @user = User.find_by(id: params[:user_id])
    @profile = User.find_by(id: params[:user_id]).profile
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
end

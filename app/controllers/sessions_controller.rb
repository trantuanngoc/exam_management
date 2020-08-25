class SessionsController < ApplicationController
  def new
  end

  def create
    user = Profile.find_by(email: params[:session][:email]).user
    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to user
    else
      flash.now[:danger]='Invalid email/password'
      render 'new'
    end
  end
end

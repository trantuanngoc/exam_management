class UsersController < ApplicationController
  def index
    @search = User.search(params[:q])
    @users = @search.result
  end
end

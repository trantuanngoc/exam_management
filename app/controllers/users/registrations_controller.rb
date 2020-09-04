# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, :redirect_unless_admin, only: [:new, :create, :destroy]
  skip_before_action :require_no_authentication

  private

  def redirect_unless_admin
    unless current_user.try(:admin?)
      flash[:error] = "Only admins can do that"
      redirect_to root_path
    end
  end

  def sign_up(_resource_name, _resource)
    true
  end
end

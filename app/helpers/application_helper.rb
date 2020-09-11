module ApplicationHelper
  def check_admin?
    current_user.admin?
  end

  def redirect_if_not_admin
    redirect_to root_path unless check_admin?
  end
end

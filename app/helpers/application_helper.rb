module ApplicationHelper
  def check_admin?
    current_user.admin?
  end
end

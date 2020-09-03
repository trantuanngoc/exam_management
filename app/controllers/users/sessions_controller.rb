# frozen_string_literal: true
module Users
  class SessionsController < Devise::SessionsController

    def after_sign_in_path_for(resource)
      super
      root_path
    end

    def after_sign_out_path_for(resource)
      super
      new_user_session_path
    end
  end
end

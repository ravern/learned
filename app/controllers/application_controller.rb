class ApplicationController < ActionController::Base
    def show_nav
        @nav = true
    end

    private
    def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
    end
end

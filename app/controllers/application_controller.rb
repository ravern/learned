class ApplicationController < ActionController::Base
    helper_method :show_nav?
    helper_method :show_create?
    helper_method :create_path

    protected
    def show_nav?
        return current_user
    end

    def show_create?
        return false
    end

    def create_path
        return "#"
    end

    private
    def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
    end
end

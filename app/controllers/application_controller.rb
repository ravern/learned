class ApplicationController < ActionController::Base
    helper_method :show_nav?
    helper_method :show_create?
    helper_method :create_path

    protected
    def show_nav?
        if current_user
            return true
        end
        return false
    end

    def show_create?
        unless current_user
            return false
        end
        if current_user.student?
            return false
        end
        return true
    end

    def create_path
        return "#"
    end

    private
    def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
    end
end

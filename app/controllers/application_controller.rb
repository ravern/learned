class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_path, :alert => "Unauthorized access!"
    end

    helper_method :show_nav?
    helper_method :show_create?
    helper_method :show_edit?
    helper_method :show_delete?
    helper_method :create_path

    protected
    def show_nav?
        return current_user
    end

    def show_create?
        return false
    end

    def show_edit?
        return false
    end

    def show_delete?
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

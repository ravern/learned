class Users::RegistrationsController < Devise::RegistrationsController
    def show_nav?
        if action_name == "edit" || action_name == "update"
            return true
        end
        return false
    end

    private
    def sign_up_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end

    def account_update_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
    end
end
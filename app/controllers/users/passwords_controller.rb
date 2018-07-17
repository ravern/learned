class Users::PasswordsController < Devise::PasswordsController
    def show_nav?
        return false
    end
end
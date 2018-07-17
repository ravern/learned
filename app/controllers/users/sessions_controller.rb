class Users::SessionsController < Devise::SessionsController
    def show_nav?
        return false
    end
end
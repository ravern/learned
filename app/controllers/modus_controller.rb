class ModusController < ApplicationController
    before_action :authenticate_user!
    before_action :show_nav

    def show
        @modu = Course.find(params[:course_id]).modus.find(params[:id])
    end
end

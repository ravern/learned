class ModusController < ApplicationController
    before_action :authenticate_user!
    before_action :show_nav

    def show
        @course = Course.find(params[:course_id])
        @modu = @course.modus.find(params[:id])
    end
end

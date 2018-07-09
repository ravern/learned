class CoursesController < ApplicationController
    before_action :authenticate_user!
    before_action :show_nav

    def index
        @courses = Course.all
    end

    def show
        @course = Course.find(params[:id])
        @modus = @course.modus
    end
end
class CoursesController < ApplicationController
    before_action :show_nav

    def index
        @courses = Course.all
    end
end
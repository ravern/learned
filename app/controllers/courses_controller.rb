class CoursesController < ApplicationController
    before_action :authenticate_user!
    before_action :show_nav

    # Authentication √
    # Authorization √
    def new
        @course = Course.new
        authorize! :create, @course
    end

    # Authentication √
    # Authorization √
    def create
        @course = current_user.courses.build(course_params)
        authorize! :create, @course

        if @course.save
            flash[:success] = 'Successfully created course!'
            redirect_to root_path
        else
            render 'courses/new'
        end
    end

    # Authentication √
    def index
        @courses = Course.all
    end

    # Authentication √
    def show
        @course = Course.find(params[:id])
        @modus = @course.modus
    end

    private
    def course_params
        params.require(:course).permit(:title, :description)
    end
end
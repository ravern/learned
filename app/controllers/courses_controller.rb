class CoursesController < ApplicationController
    before_action :authenticate_user!

    # Authentication √
    # Authorization √
    def new
        authorize! :create, Course

        @course = Course.new
    end

    # Authentication √
    # Authorization √
    def create
        authorize! :create, Course

        @course = current_user.courses.build(course_params)

        if @course.save
            flash[:success] = 'Successfully created course!'
            redirect_to root_path
        else
            render 'courses/new'
        end
    end

    # Authentication √
    def show
        @course = Course.find(params[:id])
    end

    # Authentication √
    def destroy
        @course = Course.find(params[:id])
        @course.destroy
        redirect_to root_path
    end

    protected
    def show_create?
        if action_name == "index"
            return can? :create, Course
        end
        return false
    end

    def create_path
        new_course_path
    end

    private
    def course_params
        params.require(:course).permit(:title, :description)
    end
end
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

        # So that the `user` attribute exists before adding in `student_emails`
        @course = current_user.courses.build
        @course.update(course_params)

        if @course.save
            flash[:success] = 'Successfully created course!'
            redirect_to root_path
        else
            flash[:alert] = 'Failed to create course :('
            render 'courses/new'
        end
    end

    # Authentication √
    def index
        @courses = courses
    end

    # Authentication √
    def destroy
        @course = courses.find(params[:id])
        @course.destroy
        redirect_to root_path
    end

    # Authentication √
    def edit
        @course = courses.find(params[:id])
    end

    # Authentication √
    def update
        @course = courses.find(params[:id])

        authorize! :update, @course

        @course.update(course_params)

        if @course.save
            flash[:success] = 'Successfully updated course!'
            redirect_to root_path
        else
            flash[:alert] = 'Failed to save course :('
            render 'courses/edit'
        end
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
    def courses
        if current_user.admin?
            return Course.all
        else
            return current_user.courses
        end
    end

    def course_params
        params.require(:course).permit(:title, :description, :student_emails)
    end
end
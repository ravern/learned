class CoursesController < ApplicationController
    before_action :authenticate_user!

    # Authentication √
    # Authorization √
    def new
        @course = Course.new

        authorize! :create, @course
    end

    # Authentication √
    # Authorization √
    def create
        # So that the `user` attribute exists before adding in `student_emails`
        @course = current_user.courses.build
        @course.update(course_params)

        authorize! :create, @course

        if @course.save
            flash[:success] = 'Successfully created course!'
            redirect_to root_path
        else
            flash[:alert] = 'Failed to create course :('
            render 'courses/new'
        end
    end

    # Authentication √
    # Authorization √
    def index
        @courses = courses
    end

    # Authentication √
    # Authorization √
    def destroy
        @course = courses.find(params[:id])

        authorize! :delete, @course

        @course.destroy
        redirect_to root_path
    end

    # Authentication √
    # Authorization √
    def edit
        @course = courses.find(params[:id])

        authorize! :update, @course
    end

    # Authentication √
    # Authorization √
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

    # Authentication √
    def enroll
        course = current_user.discover_courses.find(params[:course_id])
        enrollment = current_user.enrollments.build(course: course)

        if enrollment.save
            flash[:success] = 'Successfully enrolled in course!'
        else
            flash[:alert] = 'Failed to enroll in course :('
        end

        redirect_to course_modus_path(course)
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
        params.require(:course).permit(:title, :description, :public, :student_emails)
    end
end
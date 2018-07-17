class CoursesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_course!
    before_action :set_modu!

    # Authentication √
    # Authorization √
    def create
        @course = Course.new
    end

    private
    def set_course!
        @course = current_user.all_courses.find(params[:course_id])
    end

    def set_modu!
        @modu = @course.modus.find(params[:modu_id])
    end

    def comment_params
        comment_params = params.require(:comment).permit(:content)
    end
end
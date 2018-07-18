class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_course!
    before_action :set_modu!

    # Authentication √
    def create
        # Need to do it this way so @modu.comments isn't affected
        @comment = current_user.comments.build(comment_params)
        @comment.modu_id = @modu.id

        if @comment.save
            flash[:success] = 'Successfully posted comment!'
            redirect_to course_modu_path(@course, @modu)
        else
            flash[:alert] = 'Failed to post comment :('
            render 'modus/show'
        end
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
class ModusController < ApplicationController
    before_action :authenticate_user!
    before_action :set_course!

    # Authentication √
    # Authorization √
    def new
        authorize! :create, Modu

        @modu = Modu.new
    end

    # Authentication √
    # Authorization √
    def create
        authorize! :create, Modu

        @modu = @course.modus.build(modu_params)

        if @modu.save
            flash[:success] = 'Successfully created module!'
            redirect_to course_path(@course)
        else
            render 'modus/new'
        end
    end

    # Authentication √
    def index
        @modus = @course.modus
    end

    # Authentication √
    def show
        @modu = @course.modus.find(params[:id])
        @comment = current_user.comments.build
    end

    protected
    def show_create?
        if action_name == "index"
            return can? :create, Modu
        end
        return false
    end

    def create_path
        new_course_modu_path(@course)
    end

    private
    def set_course!
        @course = current_user.all_courses.find(params[:course_id])
    end

    def modu_params
        modu_params = params.require(:modu).permit(:title, :content)
    end
end

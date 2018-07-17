class ModusController < ApplicationController
    before_action :authenticate_user!
    before_action :set_course!

    # Authentication √
    # Authorization √
    def new
        @modu = Modu.new
        authorize! :create, @modu
    end

    # Authentication √
    # Authorization √
    def create
        @modu = @course.modus.build(modu_params)
        authorize! :create, @modu

        if @modu.save
            flash[:success] = 'Successfully created module!'
            redirect_to course_path(@course)
        else
            render 'modus/new'
        end
    end

    def show
        @modu = @course.modus.find(params[:id])
    end

    def set_course!
        @course = Course.find(params[:course_id])
    end

    private
    def modu_params
        modu_params = params.require(:modu).permit(:title, :content)
    end
end

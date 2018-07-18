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
            redirect_to course_modus_path(@course)
        else
            flash[:alert] = 'Failed to create module :('
            render 'modus/new'
        end
    end

    # Authentication √
    def index
        @modus = @course.modus
    end

    # Authentication √
    def complete
        @modu = @course.modus.find(params[:modu_id])

        if current_user.complete?(@modu)
            flash[:success] = 'Successfully completed module!'
            redirect_to course_modus_path(@course)
            return
        end

        @completion = Completion.new(modu: @modu, user: current_user)

        if @completion.save
            flash[:success] = 'Successfully completed module!'
            redirect_to course_modus_path(@course)
        else
            @comment = Comment.new
            render 'modus/show'
        end
    end

    # Authentication √
    def show
        @modu = @course.modus.find(params[:id])
        @comment = current_user.comments.build
        @completion = Completion.new
    end

    # Authentication √
    def destroy
        @modu = @course.modus.find(params[:id])
        @modu.destroy
        redirect_to course_modus_path(@course)
    end

    # Authentication √
    def edit
        @modu = @course.modus.find(params[:id])
    end

    # Authentication √
    def update
        @modu = @course.modus.find(params[:id])

        authorize! :update, @modu

        @modu.update(modu_params)

        if @modu.save
            flash[:success] = 'Successfully updated module!'
            redirect_to course_modus_path(@course)
        else
            flash[:alert] = 'Failed to save module :('
            render 'modus/new'
        end
    end

    protected
    def show_create?
        if action_name == "index"
            return can? :create, Modu
        end
        return false
    end

    def show_edit?
        if action_name == "index"
            return can? :update, @course
        elsif action_name == "show"
            return can? :update, @modu
        end
        return false
    end

    def show_delete?
        if action_name == "index"
            return can? :delete, @course
        elsif action_name == "show"
            return can? :delete, @modu
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

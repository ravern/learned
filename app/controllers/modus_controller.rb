class ModusController < ApplicationController
    before_action :authenticate_user!
    before_action :set_course!

    helper_method :show_modules?

    # Authentication √
    # Authorization √
    def new
        @modu = @course.modus.build

        authorize! :create, @modu
    end

    # Authentication √
    # Authorization √
    def create
        @modu = @course.modus.build(modu_params)

        authorize! :create, @modu

        if @modu.save
            flash[:success] = 'Successfully created module!'
            redirect_to course_modus_path(@course)
        else
            flash[:alert] = 'Failed to create module :('
            render 'modus/new'
        end
    end

    # Authentication √
    # Authorization √
    def index
        @modus = @course.modus
        @enrollment = Enrollment.new
    end

    # Authentication √
    # Authorization √
    def complete
        @modu = @course.modus.find(params[:modu_id])

        authorize! :complete, @modu

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
    # Authorization √
    def show
        @modu = @course.modus.find(params[:id])
        @comment = current_user.comments.build
        @completion = Completion.new
    end

    # Authentication √
    # Authorization √
    def destroy
        @modu = @course.modus.find(params[:id])

        authorize! :delete, @modu

        @modu.destroy
        redirect_to course_modus_path(@course)
    end

    # Authentication √
    # Authorization √
    def edit
        @modu = @course.modus.find(params[:id])

        authorize! :update, @modu
    end

    # Authentication √
    # Authorization √
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
            return can? :create, @modu
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
        if current_user.admin?
            @course = Course.find(params[:course_id])
        else
            courses = current_user.all_courses
            if action_name == "index"
                courses = courses.union(current_user.discover_courses)
            end

            @course = courses.find(params[:course_id])
        end
    end

    def show_modules?
        if current_user.admin?
            return true
        end
        current_user.courses.find_by(id: @course.id) || Enrollment.find_by(course: @course, user: current_user)
    end

    def modu_params
        modu_params = params.require(:modu).permit(:title, :content)
    end
end

class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course_id, only: %i[show update edit enroll destroy mark_as]
  before_action :require_admin, only: %i[new create destroy update edit]
  def index
    @courses = if params[:query].blank?
                 Course.all
               else
                 Course.filter_course(params[:query])
               end
  end

  def new
    @course = Course.new
  end

  def show
    @regestered = Enrollment::AlreadyEnrolled.call(@course, current_user)
    @number_of_enrolled_count = @course.subscribers.size
    @complete_count = UserCourse.completed_courses(@course.id)
    respond_to do |format|
      format.html
      format.json  { render json: @course }
    end
  end

  def enroll
    @enrolled = Enrollment::EnrollIn.call(@course, current_user)
    flash[:notice] = if @enrolled.save
                       'Enrolled Successfully'
                     else
                       'Something went wrong!'
                     end
    redirect_to @course
  end

  def create
    @recipent = Recipient.call(current_user)
    @course = current_user.courses.new(course_params)
    if @course.save
      redirect_to @course
    else
      flash[:danger] = 'Something Went Wrong!'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to root_path
  end

  def edit; end

  def update
    @updated = @course.update(course_params)
    if @updated
      redirect_to @course
    else
      flash[:danger] = 'Something Went Wrong!'
      render :edit, status: :unprocessable_entity
    end
  end

  def mark_as
    flash[:notice] = 'Marked as Completed'
    Enrollment::MarkAsComplete.call(@course, current_user)
    redirect_to @course
  end

  private

  def require_admin
    redirect_to root_path, notice: 'You are not an admin user!' unless current_user.admin?
  end

  def set_course_id
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:language, :user_id, :query, :name, :cover)
  end
end

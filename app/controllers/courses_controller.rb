class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course_id, only: %i[show update edit mark_as enroll destroy]
  before_action :is_admin, only: %i[new create destroy update edit]

  def index
    # binding.pry
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
    @number_of_enrolled_count = @course.users.size
    @complete_count = UserCourse.completed_courses(@course.id)
  end

  def enroll
    @enrolled = current_user.enroll_in(@course.id)
    if @enrolled.save
      flash[:notice] = 'Enrolled Successfully'
      redirect_to @course
    else
      flash[:alert] = @enrolled.errors.full_messages

    end
  end

  def create
    @course = current_user.courses.new(course_params)
    if @course.save
      redirect_to courses_path, notice: 'Course Created '
    else
      flash[:alert] = @course.errors.full_messages
      render :new, notice: 'Failed to create Course, try again!'
    end
  end

  def destroy
    @course.destroy
    redirect_to root_path
  end

  def edit; end

  def update
    @updated = @course.update(course_params)
    if @updated.save
      redirect_to @course
    else
      flash[:alert] = @updated.errors.full_messages
      render :edit
    end
  end

  def mark_as
    current_user.mark_as_(@course.id)
    redirect_to @course
  end

  private

  def is_admin
    redirect_to root_path, notice: 'You are not an admin user!' unless current_user.admin?
  end

  def set_course_id
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:language, :user_id, :query, :name)
  end
end

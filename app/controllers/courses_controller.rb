class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course_id, only: %i[show update edit mark_as enroll destroy]
  before_action :set_admin, only: %i[new create destroy update edit]

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
    @number_of_enrolled_count = @course.users.count
    @complete_count = @course.count_of_complete
  end

  def enroll
    @enrolled = current_user.enroll_in(@course.id)
    redirect_to @course, notice: 'Enrolled Successfully' if @enrolled.save
  end

  def create
    @course = current_user.courses.new(course_params)
    if @course.save
      redirect_to courses_path, notice: "Course Created "
    else
      render :new
    end
  end

  def destroy
    @course.destroy
    redirect_to root_path
  end

  def edit; end

  def update
    @course.update(course_params)
    if @course.save
      redirect_to @course
    else
      render :edit
    end
  end

  def mark_as
    current_user.mark_as_(@course.id)
    redirect_to @course
  end

  private

  def set_admin
    redirect_to root_path, notice: 'You are not an admin user!' if current_user.admin? == false
  end

  def set_course_id
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:language, :user_id, :query, :name)
  end
end

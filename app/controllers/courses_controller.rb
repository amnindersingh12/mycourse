class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course_id, only: %i[show update edit mark_as enroll destroy]
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
    @complete_count = Course.completed_course(@course).count
    @number_of_enrolled_count = Course.enrolled_users(@course).count
  end

  def enroll
    @enrolled = current_user.enroll_in(@course.id)
    redirect_to @course if @enrolled.save
  end

  def create
    @course = current_user.courses.new(course_params)
    redirect_to courses_path if @course.save
  end

  def destroy
    @course.destroy
    redirect_to root_path
  end

  def edit; end

  def update
    @course.update(course_params)
    redirect_to @course
  end

  def mark_as
    current_user.mark_as_(@course.id)
    redirect_to @course
  end

  private

  def set_course_id
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:language, :creator_id, :creator, :query, :name)
  end
end

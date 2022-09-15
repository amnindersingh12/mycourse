class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course_id, only: %i[show mark_as enroll destroy]
  def index
    @courses = Course.all
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
    if @enrolled.save
      redirect_to @course
    else
      @enrolled.errors.full_messages
    end
  end

  def create
    @course = current_user.courses.new(course_params)
    if @course.save
      redirect_to courses_path
    else
      @course.errors.full_messages
    end
  end

  def destroy
    @course.destroy
    redirect_to root_path
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
    params.require(:course).permit(:language, :creator_id, :creator, :name)
  end
end

class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
  end

  def enroll
    @course = Course.find(params[:id])
    @enrolled = current_user.enroll_in(@course.id)
    if @enrolled.save
      redirect_to @course

    else
      @enrolled.errors.full_messages
    end
  end

  def create
    @course = current_user.courses.new(course_params)
    redirect_to courses_path if @course.save
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to root_path
  end

  private

  def course_params
    params.require(:course).permit(:language, :creator, :name)
  end
end

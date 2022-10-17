class ReviewsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_course
  before_action :set_review, only: %i[index new create]

  def index; end

  def new; end

  def create
    @review = @reviews.new(review_params)
    if @review.save
      flash[:notice] = 'Review Created!'
    else
      flash[:danger] = 'Please add a review!'
    end
    redirect_to course_reviews_path
  end

  private

  def set_review
    @reviews = @course.reviews
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def review_params
    params.permit(%i[body user_id course_id])
  end
end

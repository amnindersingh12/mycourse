class ProfilesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: :ProfilesController

  def index
    @users = User.all
  end

  def show
    @courses = Course.all
    @profile = current_user
    respond_to do |format|
      format.html
      format.json { render json: @profile }
    end
  end
end

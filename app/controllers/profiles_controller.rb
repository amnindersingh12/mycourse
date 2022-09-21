class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    @courses = Course.all
    @profile = current_user
  end
end

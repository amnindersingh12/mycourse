module Enrollment
  class EnrollIn < ApplicationService
    def initialize(course, user)
      @course = course
      @user = user
    end

    def call
      @user.subscriptions.create(course_id: @course.id)
    end
  end
end

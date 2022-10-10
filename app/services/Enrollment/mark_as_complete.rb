module Enrollment
  class MarkAsComplete < ApplicationService
    def initialize(course, user)
      @course = course
      @user = user
    end

    def call
      @user.subscriptions.find_by(course_id: @course.id).update(status: 1)
    end
  end
end

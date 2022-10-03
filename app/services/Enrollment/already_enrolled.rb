module Enrollment
  class AlreadyEnrolled < ApplicationService
    def initialize(course, user)
      @course = course
      @user = user
    end

    def call
      @user.courses.include?(@course)
    end

    private

    def already_enrolled?
      AlreadyEnrolled.call(@course, @user)
    end
  end
  
end

class CourseNotificationJob < ApplicationJob
  queue_as :default

  def perform(recipent, course)
    UserMailer.send_notification(recipent, course)
  end
end

class CourseNotificationJob < ApplicationJob
  queue_as :default

  def perform(recipent, course)
    recipent.each do |email|
      UserMailer.send_notification(email, course).deliver_later
    end
  end
end

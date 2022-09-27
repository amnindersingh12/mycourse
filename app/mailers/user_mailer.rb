class UserMailer < ApplicationMailer

  def send_notification(recipent, course)
    @course = course
    mail(
      to: recipent,
      subject: 'New Course Available'
    )
  end
end

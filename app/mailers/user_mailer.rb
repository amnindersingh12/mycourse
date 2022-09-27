class UserMailer < ApplicationMailer
  def send_notification(recipent, course)
    @course = course
    # binding.pry
    mail(
      to: recipent,
      subject: 'New Course Available'
    )
  end
end

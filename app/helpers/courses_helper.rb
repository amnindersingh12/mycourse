module CoursesHelper
  def datetime_format(localtime)
    localtime.strftime('%A, %b %e, at %l:%M %p')
    #                   week,month,day at hr,min,am/pm
  end

  def current_subscription(id)
    current_user.subscriptions.find_by(course_id: id)
  end

  def show_status(course)
    current_subscription(course).status == 'completed' ? 'Completed' : 'In Progress'
  end

  def enrolled_at(course)
    datetime_format current_subscription(course).created_at
  end

  def completed_at(course)
    datetime_format current_subscription(course).updated_at
  end
end

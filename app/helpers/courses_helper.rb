module CoursesHelper
  # TODO: need to refactor this current_subscription
  def current_subscription(id)
    current_user.subscriptions.find_by(course_id: id)
  end

 
end

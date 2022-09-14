module CoursesHelper
  def mark_as_(course)
    status_of_course = UserCourse.where(user_id: current_user.id, course_id: course.id).status
    if status_of_course == 'inprogress'
      :completed
    else
      :inprogress
    end
  end
end

module CoursesHelper
  def display_course(id)
    Course.find(id)
  end

  def show_status(course)
    UserCourse.find_by(user_id: current_user.id, course_id: course.id).status
  end
end

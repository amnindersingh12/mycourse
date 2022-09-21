module CoursesHelper
  def show_status(course)
    current_user.user_courses.find_by(course_id: course.id).status == 'completed' ? 'Completed' : 'In Progress'
  end

  def enrolled_at(course)
    current_user.user_courses.find_by(course_id: course.id).created_at.strftime('%m/%d/%Y, %H:%M:%S')
  end

  def completed_at(course)
    current_user.user_courses.find_by(course_id: course.id).updated_at.strftime('%m/%d/%Y, %H:%M:%S')
  end
end

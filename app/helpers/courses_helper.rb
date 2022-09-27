module CoursesHelper
  def datetime_format(localtime)
    localtime.strftime('%A, %b %e, at %l:%M %p')
    #                   week,month,day at hr,min,am/pm
  end

  def find_course(course)
    current_user.user_courses.find_by(course_id: course.id)
  end

  def show_status(course)
    find_course(course).status == 'completed' ? 'Completed' : 'In Progress'
  end

  def enrolled_at(course)
    datetime_format find_course(course).created_at
  end

  def completed_at(course)
    datetime_format find_course(course).updated_at
  end
end

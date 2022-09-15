module CoursesHelper
  def display_course(id)
    Course.find(id)
  end
end

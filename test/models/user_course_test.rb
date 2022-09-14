# == Schema Information
#
# Table name: user_courses
#
#  id         :integer          not null, primary key
#  status     :string           default("inprogress")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_user_courses_on_course_id  (course_id)
#  index_user_courses_on_user_id    (user_id)
#
# Foreign Keys
#
#  course_id  (course_id => courses.id)
#  user_id    (user_id => users.id)
#
require "test_helper"

class UserCourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

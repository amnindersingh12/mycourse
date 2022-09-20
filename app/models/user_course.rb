# == Schema Information
#
# Table name: user_courses
#
#  id         :integer          not null, primary key
#  status     :integer          default(0)
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
class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  validates :user_id, uniqueness: { scope: :course_id }

  enum :status, [:inprogress, :completed]
end


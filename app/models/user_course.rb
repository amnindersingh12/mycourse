# == Schema Information
#
# Table name: user_courses
#
#  id         :integer          not null, primary key
#  status     :integer          default("inprogress")
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
  # self.table_name = "course_users"
  belongs_to :user
  belongs_to :course
  validates :user_id, uniqueness: { scope: :course_id }

  enum :status, %i[inprogress completed]
  # scope :completed_courses, ->(q) { where(course_id: q, status: true).size }

  def self.cached_completed_size(id)
    Rails.cache.fetch([self, id]) { where(course_id: id, status: true).size }
  end

  # SELECT COUNT(*) FROM "user_courses" WHERE "user_courses"."course_id" = q AND "user_courses"."status" = true
end

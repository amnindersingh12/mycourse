# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  creator    :string
#  language   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :integer
#
class Course < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  validates :name, uniqueness: true
  validates :language, :creator, :creator_id, presence: true

  before_save :capitalize_everything

  def capitalize_everything
    self.language = language.capitalize
  end

  scope :completed_course, ->(id) { UserCourse.where(course_id: id, status: :completed) }
  scope :enrolled_users, ->(id) { UserCourse.where(course_id: id) }
  scope :filter_course, ->(q) { where(language: q.capitalize) }
end

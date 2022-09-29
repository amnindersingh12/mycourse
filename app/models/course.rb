# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  language   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_courses_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Course < ApplicationRecord
  # user course relationship for current course and users
  has_many :subscriptions, class_name: 'UserCourse', dependent: :destroy

  # users enrolled in the course
  has_many :subscribers, through: :subscriptions, source: :user

  validates :name, uniqueness: true
  validates :language, :name, presence: true
  has_one_attached :cover

  # list the admin of the course
  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  before_save do
    self.language = language.capitalize
  end

  after_save do
    CourseNotificationJob.perform_later(Recipient.new(owner).list_of_recipient, Course.last)
  end

  scope :filter_course, ->(q) { where(language: q.capitalize) }
end

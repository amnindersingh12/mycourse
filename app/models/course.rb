# == Schema Information
#
# Table name: courses
#
#  id           :integer          not null, primary key
#  language     :string
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  superuser_id :integer
#  user_id      :integer          not null
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

  validates :name, presence: true, uniqueness: true
  validates :language, presence: true, unless: proc { |course| is_admin? course.user_id }
  has_one_attached :cover

  # list the admin of the course
  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  # list the superuser of the course
  belongs_to :superuser, class_name: 'User', foreign_key: :superuser_id

  before_save :capi, unless: proc { |course| is_admin? course.user_id }

  def capi
    self.language = language.capitalize
  end

  after_create_commit do
    CourseNotificationJob.perform_later(Recipient.call(owner), Course.last)
  end

  def is_admin?(id)
    User.find(id).role == "admin"
  end

  def self.superuser?(id)
    Course.all.pluck(:superuser_id).uniq.include?(id)
  end
  scope :filter_course, ->(q) { where(language: q.capitalize) }
end

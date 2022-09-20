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
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  validates :name, uniqueness: true
  validates :language, :name, presence: true

  belongs_to :admin_user, class_name: 'User', foreign_key: :user_id
  before_save :capitalize_everything

  def capitalize_everything
    self.language = language.capitalize
  end

  def count_of_complete
    user_courses.where(status: true).count
  end

  scope :filter_course, ->(q) { where(language: q.capitalize) }
end

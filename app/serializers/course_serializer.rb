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
class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :language
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_many :subscribers, through: 'UserCourse', source: :user
end

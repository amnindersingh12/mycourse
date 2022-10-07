class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :role
  has_many :main_courses, class_name: 'Course'
end

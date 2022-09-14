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
#
class Course < ApplicationRecord
  has_many :user_courses
  has_many :users, through: :user_courses
  validates :name, uniqueness: true
end

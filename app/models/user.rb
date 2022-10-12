# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("member")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable
  validates :name, presence: true

  #  courses in which user is regestered (join table)
  has_many :subscriptions, class_name: 'UserCourse', dependent: :destroy

  # list of courses with their name and language
  has_many :courses, through: :subscriptions

  # courses created by the user
  has_many :main_courses, class_name: :Course

  # courses managed by the user
  has_many :super_courses, class_name: :Course, foreign_key: :superuser_id

  enum :role, %i[member admin superuser], default: :member
end

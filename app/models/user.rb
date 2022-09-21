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
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  validates :name, presence: true

  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses

  enum :role, %i[member admin]

  def enroll_in(course)
    user_courses.create(course_id: course)
  end

  def already_enrolled?(course)
    courses.include?(course)
  end

  def mark_as_(id)
    user_courses.find_by(course_id: id).update(status: 1)
  end
end

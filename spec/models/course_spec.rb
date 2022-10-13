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
require 'rails_helper'

describe Course, type: :model do
  include_context 'db_cleanup'

  before { create(:admin_user) }

  it 'is invalid without a owner' do
    course = build(:course, user_id: nil)
    course.valid?
    expect(course.errors[:owner]).to(include('must exist'))
  end

  it 'is valid with name, language and Owner (user_id)' do
    expect(build(:course, user_id: User.last.id)).to(be_valid)
  end

  it 'is invalid without a name' do
    course = build(:course, name: nil)
    course.valid?
    expect(course.errors[:name]).to(include("can't be blank"))
  end

  it 'is invalid without a language' do
    course = build(:course, language: nil)
    course.valid?
    expect(course.errors[:language]).to(include("can't be blank"))
  end

  it 'is invalid with a duplicate name' do
    create(:course, name: 'user_xyz')
    course = build(:course, name: 'user_xyz')
    course.valid?
    expect(course.errors[:name]).to(include('has already been taken'))
  end
end

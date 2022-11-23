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

  context 'validation' do
    let(:u1) { Course.new(language: 'php', name: 'a', user_id: 1, superuser_id: 1) }
    let(:u2) { Course.new(language: 'php', name: nil, user_id: 1, superuser_id: 2) }

    context 'when user is with superuser_id 1' do
      before { allow(u1).to receive(:name) }
      it { expect(u1).to validate_presence_of(:name) }
    end

    context 'when user is not with superuser_id 1' do
      it { expect(u2).not_to validate_presence_of(:name) }
    end
  end

  before { create(:admin_user) }

  it 'is invalid without a owner' do
    course = build(:course, user_id: nil)
    course.valid?
    expect(course.errors[:owner]).to(include('must exist'))
  end

  it 'is valid with name, language and Owner (user_id)' do
    expect(build(:course, user_id: User.last.id)).to(be_valid)
  end

  xit 'is invalid without a name' do
    course = build(:course, name: nil)
    course.valid?
    expect(course.errors[:name]).to(include("can't be blank"))
  end

  it 'is invalid without a language' do
    course = build(:course, language: nil)
    course.valid?
    expect(course.errors[:language]).to(include("can't be blank"))
  end

  xit 'is invalid with a duplicate name' do
    create(:course, name: 'user_xyz')
    course = build(:course, name: 'user_xyz')
    course.valid?
    expect(course.errors[:name]).to(include('has already been taken'))
  end
end

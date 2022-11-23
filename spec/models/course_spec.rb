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

  describe 'validation' do
    context 'if not admin' do
      let(:c1) { Course.new(language: 'js', name: 'course1', user_id: 3, superuser_id: 3) }

      before do
        allow(c1).to receive(:is_admin?).and_return(false)
      end
      it { expect(c1).to validate_presence_of(:name) }
    end

    context 'if admin' do
      let(:c2) { Course.new(language: 'js', name: nil, user_id: 1, superuser_id: 1) }

      before do
        allow(c2).to receive(:is_admin?).and_return(true)
      end
      it { expect(c2).to validate_presence_of(:name) }
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

  it 'is invalid without a name' do
    course = build(:course, name: nil)
    course.valid?
    expect(course.errors[:name]).to(include("can't be blank"))
  end

  xit 'is invalid without a language' do
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

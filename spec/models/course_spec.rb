require 'rails_helper'

RSpec.describe Course, type: :model do
  include_context "db_cleanup"
  include_context "db_scope"

  before { create(:admin_user) }

  it 'is invalid without a owner' do
    course = build(:course, user_id: nil)
    course.valid?
    expect(course.errors[:owner]).to include("must exist")
  end

  it 'is valid with Course name, Course language and Course Owner (user_id)' do
    expect(build(:course, user_id: User.last.id )).to be_valid
  end
  it 'is invalid without a name' do
    course = build(:course, name: nil)
    course.valid?
    expect(course.errors[:name]).to include("can't be blank")
  end
  it 'is invalid without a language' do
    course = build(:course, language: nil)
    course.valid?
    expect(course.errors[:language]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    create(:course, name: "user_xyz")
    course = build(:course, name: "user_xyz")
    course.valid?
    expect(course.errors[:name]).to include("has already been taken")
  end

end

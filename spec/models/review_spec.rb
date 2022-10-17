# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_reviews_on_course_id  (course_id)
#  index_reviews_on_user_id    (user_id)
#
# Foreign Keys
#
#  course_id  (course_id => courses.id)
#  user_id    (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Review, type: :model do
  include_context 'db_cleanup'
  before do
    create(:admin_user)
    create(:course)
  end

  it 'is valid with review body' do
    expect(create(:review)).to(be_valid)
  end
  it 'is invalid without review body' do
    review = build(:review, body: nil)
    review.valid?
    expect(review.errors[:body]).to(include("can't be blank"))
  end
end

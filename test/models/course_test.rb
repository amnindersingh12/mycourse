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
#  creator_id :integer
#
require "test_helper"

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

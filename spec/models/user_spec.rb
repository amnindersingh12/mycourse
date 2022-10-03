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
require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with name' do
      expect(build(:member_user)).to be_valid
  end
  it 'is invalid without name' do
    expect(build(:member_user, name: nil)).not_to be_valid
  end
end

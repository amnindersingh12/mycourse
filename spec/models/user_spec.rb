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
require 'cancan/matchers'

describe(User, type: :model) do
  context 'when name is valid' do
    it { expect(build(:member_user)).to(be_valid) }
  end
  context 'when name is invalid' do
    it { expect(build(:member_user, name: nil)).not_to(be_valid) }
  end
  describe 'abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { build(:admin_user) }
    let(:course) { build(:course) }

    context 'when admin' do
      describe 'can manage all action' do
        let(:user) { build(:admin_user) }

        it { is_expected.to(be_able_to(:manage, Course.new(user_id: user.id))) }
      end
    end

    describe 'when member user' do
      let(:user) { build(:member_user) }

      context 'can read and enroll' do
        %i[enroll read read mark_as].each do |role|
          it { is_expected.to(be_able_to(role, Course.new)) }
        end
      end
      context 'cannot manage' do
        %i[create edit destroy].each do |role|
          it { is_expected.not_to(be_able_to(role, course)) }
        end
      end
    end

    context 'when superuser' do
      let(:user) { build(:super_user) }
      context 'can read and enroll' do
        %i[enroll read mark_as].each do |role|
          it { is_expected.to(be_able_to(role, Course.new)) }
        end
      end
      context 'can update' do
        it { is_expected.to(be_able_to(:update, Course.new(superuser_id: user.id))) }
      end
      context 'cannot manage' do
        %i[create destroy].each do |role|
          it { is_expected.not_to(be_able_to(role, course)) }
        end
      end
    end
  end

  # describe User do
  #   it 'is available as described_class' do
  #     expect(described_class).to(eq(User))
  #   end
  # end
end

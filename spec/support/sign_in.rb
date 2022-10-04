shared_context :log_in_member_user do
  let(:member_user) { create(:member_user) }
  before { sign_in member_user }
end

shared_context :log_in_admin_user do
  let(:admin_user) { create(:admin_user) }
  before { sign_in admin_user }
end

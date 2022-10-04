FactoryBot.define do
  factory :member_user, class: 'user' do
    name { "member_#{Faker::Name.first_name}" }
    email { "member_#{Faker::Internet.email}" }
    password { 'password' }
  end
  factory :admin_user, class: 'user' do
    name { "admin_#{Faker::Name.first_name}" }
    email { "admin_#{Faker::Internet.email}" }
    password { 'password' }
    role { 'admin' }
  end
end

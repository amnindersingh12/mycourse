FactoryBot.define do
  factory :course do
    language { 'Js' }
    name { "course_#{Faker::Name.first_name.reverse.camelize.reverse}" }
    user_id { 1 }
  end
end

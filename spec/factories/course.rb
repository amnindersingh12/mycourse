FactoryBot.define do
  factory :course do
    language { 'Js' }
    name { "course_#{Faker::Name.first_name}" }
    user_id { 1 }
  end
end

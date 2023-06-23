FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    code { Faker::Alphanumeric.unique.alphanumeric(number: 4).upcase }
  end
end

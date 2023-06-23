FactoryBot.define do
  factory :tutor do
    name { Faker::Name.name }
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    association :course, factory: :course
  end
end

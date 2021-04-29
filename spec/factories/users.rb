FactoryBot.define do
  factory :user do
    email
    password { 'password' }

    trait :invalid do
      email { nil }
    end
  end
end

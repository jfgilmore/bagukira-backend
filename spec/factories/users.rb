FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "username#{n}@domain.com"
    end

    trait :invalid do
      email { nil }
    end
  end
end

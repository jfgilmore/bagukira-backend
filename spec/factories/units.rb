FactoryBot.define do
  factory :unit do
    sequence :name do |n|
      "Test Project No.#{n}"
    end
    unit_type { 0 }
    user { create(:user) }

    trait :invalid do
      name { nil }
    end
  end
end

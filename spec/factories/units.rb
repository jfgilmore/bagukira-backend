FactoryBot.define do
  factory :unit do
    name { 'Test Project' }
    unit_type { 0 }
    user { create(:user) }

    trait :invalid do
      name { nil }
    end
  end
end

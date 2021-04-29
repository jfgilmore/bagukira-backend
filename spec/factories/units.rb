FactoryBot.define do
  factory :unit do
    sequence :name do |n|
      "Project #{n}"
    end
    unit_type
    unit_hash
    association :user, id: 0

    trait :invalid do
      name { nil }
    end
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :unit do
    sequence :name do |n|
      "Project #{n}"
    end
    unit_type do
      t = %i[project team organisation]
      t[(rand(0...2))]
    end
    unit_hash
    association :user, id: 0

    trait :invalid do
      name { nil }
    end
  end
end

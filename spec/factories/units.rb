FactoryBot.define do
  factory :unit, aliases: [:project, :team, :organisation] do
    sequence :name do |n|
      "Test Project No.#{n}"
    end
    unit_type { :project }
    user_id { create(:user).id }

    trait :invalid do
      name { nil }
    end
  end
end

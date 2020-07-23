FactoryBot.define do
  factory :unit, aliases: [:project, :team, :organisation] do
    sequence :name do |n|
      "Test Project No.#{n}"
    end

    trait :with_hash do
      unit_hash { Digest::SHA256.hexdigest(rand(1000).to_s) }
    end

    unit_type { :project }
    user_id { create(:user).id }

    trait :invalid do
      name { nil }
    end
  end
end

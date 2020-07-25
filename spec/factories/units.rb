FactoryBot.define do
  factory :unit do
    sequence :name do |n|
      "Test Project No.#{n}"
    end
    unit_hash { Digest::SHA256.hexdigest(rand(1000).to_s) }
    unit_type { :project }
    user { User.first || association(:user) }

    # trait :new_user do
    #   user { association(:user) }
    # end

    trait :invalid do
      name { nil }
    end
  end
end

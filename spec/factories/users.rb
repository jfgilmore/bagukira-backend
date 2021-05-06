# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email
    password { 'password' }

    trait :invalid do
      email { 'testemail' }
    end

    trait :missing_email do
      email { nil }
    end
  end
end

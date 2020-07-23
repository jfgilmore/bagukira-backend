FactoryBot.define do
  factory :ticket, aliases: [:bug] do
    sequence :subject do |n|
      "Bug Report #{n}"
    end
    status { :open }
    opened_by { 'Josh' }
    description { 'Something to do with CI.' }

    trait :new_unit do
      unit_id { create(:unit, :with_hash).unit_hash }
    end

    trait :closed do
      closed_by { 'Jake' }
      status { 2 }
    end

    trait :invalid_subject do
      subject { nil }
    end

    trait :invalid_opened_by do
      opened_by { nil }
    end

    factory :new_ticket, traits: [:new_unit]
  end
end

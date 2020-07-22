FactoryBot.define do
  factory :ticket, aliases: [:bug] do
    sequence :subject do |n|
      "Bug Report #{n}"
    end
    status { 0 }
    opened_by { 'Josh' }
    description { 'Something to do with CI.' }

    trait :new_unit do
      unit_id { create(:unit).id }
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
  end

  factory :new_ticket, traits: [:new_unit]
end

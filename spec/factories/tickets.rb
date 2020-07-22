FactoryBot.define do
  factory :ticket do
    sequence :subject do |n|
      "Bug Report #{n}"
    end
    status { 0 }
    opened_by { "Josh" }
    description { "Something to do with CI." }
    unit { create(:unit).id }

    trait :closed do
      closed_by { "Jake" }
    end

    trait :invalid do
      subject { nil }
      opened_by { nil }
    end
  end
end

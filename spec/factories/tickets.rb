FactoryBot.define do
  factory :ticket do
    sequence :subject do |n|
     { "Bug Report #{n}" }
    end
    status { 0 }
    opened_by { "Josh" }
    closed_by { "Jake" }
    description { "Something to do with CI." }
    unit { create(:unit).id }
  end
end

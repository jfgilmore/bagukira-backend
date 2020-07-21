FactoryBot.define do
  factory :ticket do
    subject { "MyString" }
    status { 1 }
    opened_by { "MyString" }
    closed_by { "MyString" }
    description { "MyString" }
    unit { "" }
  end
end

FactoryBot.define do
  sequence :email do |n|
    "#{n}@domain.com"
  end

  sequence :unit_hash do |n|
    Digest::SHA256.hexdigest(n.days.ago.to_s)
  end

  sequence :unit_type do
    rand(1..2)
  end
end

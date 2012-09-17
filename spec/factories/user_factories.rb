FactoryGirl.define do
  factory :user do
    name 'Malk'
    sequence(:email) {|n| "tribble-#{n}@example.com" }
    after(:build) { |u| u.authorizations << build(:authorization, user: u) }
  end

  factory :authorization do
    user
    provider 'factory_girl'
    sequence(:uid) { |n| n.to_s }
  end
end

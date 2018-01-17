FactoryGirl.define do
  factory :user do
    email     {Faker::Internet.email}
    password  'testpass'
  end
end

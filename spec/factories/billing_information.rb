require 'spec_helper'

FactoryGirl.define do
  factory :billing_information do
    first_name 'test first'
    last_name 'test last'
    address1 'test addr1'
    address2 'test addr2'
    city 'test city'
    state 'test state'
    zipcode 'test zip'
    user
  end
end
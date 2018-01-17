require 'spec_helper'

FactoryGirl.define do
  factory :message_level do
    name 'testname'
    level 1
    code 'testcode'
    app
  end
end

require 'spec_helper'

FactoryGirl.define do
  factory :message do
    event '{"testevent":"testdata"}'
    app
  end
end
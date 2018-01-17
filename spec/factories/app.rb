require 'spec_helper'

FactoryGirl.define do
  factory :app do
    name       'goonsquad'
    app_token  'testtoken'
    user
  end
end
require 'spec_helper'

FactoryGirl.define do

  factory :signup_key do
    key 'goonsquad'

    trait :not_valid do
      isvalid false
    end

    trait :is_valid do
      isvalid true
    end

    trait :multi_use do
      key_type 2
    end

    trait :single_use do
      key_type 1
    end
  end

  # factory :invalid_single_default_key,  traits: [:not_valid, :single_use]
  # factory :valid_multiuse_key,          traits: [:is_valid, :multi_use]

end

class BillingInformation
  include Mongoid::Document

  embedded_in :user

  field :first_name, type: String
  field :last_name, type: String
  field :address1, type: String
  field :address2, type: String
  field :city, type: String
  field :state, type: String
  field :zipcode, type: String
  field :cc_number, type: Hash
  field :verification_code, type: String

end

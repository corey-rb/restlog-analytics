class MessageLevel
  include Mongoid::Document

  field :name, type: String
  field :level, type: Integer
  field :code, type: String

  #embedded_in :app

  scope :by_code, -> (codes){ where('code' => { '$in' => codes}) unless codes.blank?}
  scope :by_level, ->(level) { where :level => level }

end

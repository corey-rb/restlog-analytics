### MessageCollection.rb
### These are defined messages by specific criteria.  "empty" containers that can load messsages
### by criteria of the root value

class MessageCollection
  include Mongoid::Document

    field :name, type: String
    field :description, type:String
    field :r, as: :collection_criteria_property, type: String
    field :rv, as: :criteria_value, type: String
    field :g, as: :global, type: Boolean, :default => false

    belongs_to :app
    belongs_to :user

    validates :name, length: { maximum: 75 }
    validates :description, length:{ maximum: 300 }
    validates :collection_criteria_property, length:{ maximum: 128 }

    scope :by_user, -> (user)   { where :user => user }
    scope :by_app,  -> (app) { where :app => app unless app.blank? }

    # scope :tagged, ->(codes){ where('tags.code' => { '$in' => codes } ) unless codes.blank?  }

end

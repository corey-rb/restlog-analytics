class App
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  has_many :messages, dependent: :delete
  has_many :message_collections, class_name: "MessageCollection"

  embeds_many :message_levels


  field :name, type: String
  field :host, type: String  #TODO: Not needed, removed
  field :app_token, type: String
  field :hex, as: :hex_color_label, type: String
  field :monitor, type: Boolean

  validates :name, presence: true
  validates :app_token, presence: true
  validates :user, presence: true

  scope :user_apps, -> (user){where :user => user }
  scope :app_messages, -> (app_id){where :id => app_id} #TODO WTF Is this for
  scope :by_token, -> (token){ where( :app_token => token )}

  def self.create_unique_app_token
    enc = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    return (0...18).map { enc[rand(enc.length)] }.join
  end

  def get_message_collection col_id
    if message_collections.any?
      collection = message_collections.select{ |mc| mc.id.to_s.eql? col_id.to_s }.first
    end
  end

end

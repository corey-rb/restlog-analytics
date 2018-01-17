class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  before_save :process_json_event

  belongs_to :app

  field :application_name, type: String
  field :event, type: String
  field :event_data, type: Hash, :default => Hash.new
  field :create_date, type: Date, :default => Date.today()

  # todo: this will change to user defined log levels
  field :level, type: Integer, default: ->{ 1 }

  validates :app, presence: true

  class << self
    def get_by_date(day)
      where(:created_at.gt => day).and(:created_at.lt => day)
    end
  end

  scope :application_name, -> (application_name){ where application_name: application_name }
  scope :level, -> (level){ where level: level }
  scope :app_id, -> (app_ids) {where(:app_id.in => app_ids)}
  scope :created_after, -> (date) { where(:created_at.gt => date)}
  scope :created_before, -> (date) { where(:created_at.lt => date)}
  scope :from_date, ->(messageDate){where(:created_at => messageDate)}
  scope :by_query_regex, -> (query) { where( query => { '$regex' => /^/ }) }
  scope :by_query, -> (query){ where( query.collection => query.criteria ) unless query.nil? }


        scope :by_user, ->(user){ where( 'app.user' => { '$eq' => user}) }  # doesnt work

  index({ created_at: 1 })
  index 'app.id' => 1

  protected
  def process_json_event
    self.event_data = JSON.parse(self.event) unless self.event.nil?
  end

end

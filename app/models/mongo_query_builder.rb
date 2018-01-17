require 'singleton'

class MongoQueryBuilder
  include Singleton

  MESSAGE = 'event_data'

  def initialize
  end

  def build_message_query_from_message_collection collection

    criteria = ''
    criteria = collection.criteria_value unless collection.criteria_value.blank?

    query_collection = "#{MESSAGE}.#{collection.collection_criteria_property}"

    query = MongoQuery.new query_collection, criteria

   #db.messages.find( { 'event_data.apptype': { $regex: /^/ } } )
  end
end


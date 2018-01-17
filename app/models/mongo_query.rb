class MongoQuery
  attr_accessor :criteria, :collection

  @criteria
  @collection

  def initialize collection, criteria
    @collection = collection
    @criteria = criteria
  end

end
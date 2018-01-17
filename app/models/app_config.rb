class AppConfig
  include Mongoid::Document
  field :version, type: String

  class << self
    def version
      Rails.application.config.version
    end
  end

end
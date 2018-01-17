#
# A singleton class to manage the lookup for predefined error messages for use in the API
#

require 'singleton'

class ErrorDictionary
  include Singleton
  #TODO initalize all error config

  @definitions

  def initialize
    @definitions = Array.new

    api_1 = ErrorDefinition.new 'api_no_app_levels', 'The app is not set to log this level'
    @definitions.push(api_1)
    api_2 = ErrorDefinition.new 'app_find_error', 'Cannot find the specified app by key'
    @definitions.push(api_2)
  end


  def get_message code
    selected_defs = @definitions.select{ |d| d.code == code }
    if selected_defs.length > 0
      selected_defs[0]
    end
  end

end

require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Restlog
  class Application < Rails::Application
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Heroku requires this to be false
    #config.assets.initialize_on_precompile=false

    config.filter_parameters += [:password, :password_confirmation]

    config.autoload_paths += %W["#{config.root}/app/validators/"]

    config.generators do |g|
      g.view_specs false
      g.helper_specs false
    end

    config.version = '0.3.3'

  end
end

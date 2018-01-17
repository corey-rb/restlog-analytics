class ConfigurationController < ActionController::Base
  def index
    @config = AppConfig

    respond_to do |format|
      format.json{ render 'application/app_config', :content_type => 'application/json' }
    end
  end
end
class AngularController < ActionController::Base

  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  append_view_path "#{Rails.root}/app/views"

  respond_to :json

end

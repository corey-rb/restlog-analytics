class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, :only => :index

  #skip_before_filter :authenticate_user!

  def index
    if !user_signed_in?
      puts 'REDIRECT'
      redirect_to '/users/sign_in'
    else
      #puts 'I S  L O G G E D  I N'
      @version = Restlog::Application.config.version
      render layout: 'angular'
    end
  end

end

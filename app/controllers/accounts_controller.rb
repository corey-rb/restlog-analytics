class AccountsController < AngularController

  respond_to :json, :msgpack
  skip_before_action :verify_authenticity_token

  def show
    begin
      @user = User.find(current_user.id)
      respond_to do |format|
        format.json{ render 'accounts/show', :content_type => 'application/json' }
      end
    rescue Exception => e
      #TODO raise error
      @notification = { message: e.message }
      respond_to do |format|
        format.json{ render 'errors/show_base', :content_type => 'application/json', status: :forbidden }
      end
    end

  end

end

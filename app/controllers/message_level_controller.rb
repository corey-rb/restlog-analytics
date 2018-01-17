class MessageLevelController < AngularController
  respond_to :json

  def index
    @levels = MessageLevel.all

    respond_to do |format|
      format.json{ render 'message_level/index' }
    end
  end
end

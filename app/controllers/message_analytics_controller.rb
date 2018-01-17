require 'date'
require 'time'

class MessageAnalyticsController < AngularController
  respond_to :json, :msgpack
  skip_before_action :verify_authenticity_token

  ########################################################
  #
  # Return message count for top 5 apps
  #
  ########################################################
  def daily_app_message_count
    if !user_signed_in?
      not_signed_in
    end

    @user_apps = App.user_apps(current_user).order_by(:updated_at.desc).limit(5)

    @report = {}

    for i in 0..Array(@user_apps).length
      a = @user_apps[i]
      if !a.nil?
        daily_count = Array(a.messages.where(created_at: (1.days.ago..Time.now))).length
        @report.store(a.name, daily_count)
      end
    end

    respond_to do |format|
      format.json{ render 'message_analytics/daily_app_message_count', :content_type => 'application/json'}
    end

  end

  ########################################################
  #
  # Return message count since last viewed timestamp
  #
  ########################################################
  def new_messages_since_timestamp
    if !user_signed_in?
      not_signed_in
    end

    new_messages = {}
    user_apps = current_user.apps.only(:_id).map(&:_id)

    if params[:lastUpdate].nil?
      lastLoginDate = Date.today
    else
      lastLoginDate = Time.at(params[:lastUpdate].to_i)
    end

    @msgcount = Message.app_id(user_apps).created_after(lastLoginDate).to_a.count


    respond_to do |format|
      format.json{ render 'message_analytics/new_messages_count', :content_type => 'application/json' }
    end
  end

  ########################################################
  #
  #
  #
  ########################################################
  def app_data
    @user = User.find(current_user.id)
    appId = params[:appId]
    appIds = [appId]
    @appMsgs = Message.app_id(appIds).to_a.count
    puts "\n\nMESSAGE COUNT APP DATA" + @appMsgs.to_s

    render json: @appMsgs
  end
  #
  #
  #
  # def dashboard
  #   #@messages = Message.all.page(params[:page]).per(25)
  #   userId = current_user.id
  #   @user_apps = current_user.apps.only(:_id).to_a
  #   print "user app ids: " + @user_apps[0]._id
  #
  #   @user_apps = App.user_apps(current_user).order_by(:updated_at.desc).limit(5)
  #
  #   @report = {}
  #
  #   for i in 0..Array(@user_apps).length
  #     a = @user_apps[i]
  #     if !a.nil?
  #       daily_count = Array(a.messages.where(created_at: (1.days.ago..Time.now))).length
  #       @report.store(a.name, daily_count)
  #     end
  #   end
  #
  #  respond_to do |format|
  #    format.json{ render 'message_analytics/daily_app_message_count', :content_type => 'application/json'}
  #  end
  #
  #
  # end

  private
    def message_params
      params.require[:message].permit(:level,:application_name,:long_message,:short_message,:app_id)
    end

    def not_signed_in
      respond_to do |format|
        @notification = { message: 'failure' }
        format.json{ render 'errors/show_base', :content_type => 'application/json', status: :forbidden }
      end
    end

  def last_update_params
    params.permit(:last_viewed)
  end

end

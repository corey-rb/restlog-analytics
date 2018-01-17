class Api::V1::MessagesController < ApiController
  respond_to :json
  append_view_path "#{Rails.root}/app/views"


  #todo resolve this
  skip_before_action :verify_authenticity_token


  #------------
  # Build Message on POST Request
  # - Check message against the users apps,
  # - then check if that app is set to monitor the log level
  #---------
  def create
    begin
      error_dict = ErrorDictionary.instance
      #puts 'create - messages_controlelr'
      if api_params.has_key? :app_key and api_params.has_key? :api_key
        if  !api_params[:api_key].empty? and !api_params[:app_key].empty?
          user = User.find_by(:account_key => api_params[:api_key])
          if !user.nil?
            app = App.user_apps(user).find_by(:app_token => api_params[:app_key])
            if !app.nil?
              @message = Message.create(message_params)
              if !app.message_levels.nil?
                #puts app
                #puts @message.level
                if App.where(:'message_levels.level' => @message.level).where(:id => app.id).count > 0
                  if app.monitor == true
                    @message.app = app
                    if @message.valid? and @message.save
                      app.updated_at = DateTime.now
                      app.save
                      # return successful
                 #     puts 'success'
                      respond_to do |format|
                        format.json{ render 'api/v1/messages/create', :content_type=>'application/json' }
                      end
                    else
                      #message is not valid and saved failed
                      respond_to_with_code error_dict, 'message_not_valid'
                    end
                  else
                    #app monitor is switched off
                    respond_to_with_code error_dict, 'app_monitor_off'
                  end

                else
                  #error app is not set to log this app level
                  respond_to_with_code error_dict, 'app_not_monitoring_level1'
                end
              else
                #error app is not set to log this app level
                respond_to_with_code error_dict, 'app_not_monitoring_level'
              end
            else
              #app find error
              respond_to_with_code error_dict, 'app_find_error'
            end
          else
            #user is invalid error
            respond_to_with_code error_dict, 'user_invalid_error'
          end
        else
          #parameters exist, but are empty error
          respond_to_with_code error_dict, 'empty_parameters'
        end

      else
        #MISSING PARAMTERS ERROR
        respond_to_do_error
      end
    rescue Exception => e
      respond_to_do_error
    end
  end

  private
  def message_params
    params.require(:message).permit(:application_name, :event, :level)
  end

  def api_params
    params.require(:restlog).permit(:api_key, :app_key)
  end

  def respond_to_do_error
    response = { errors: ['missing api key and/or app key']}
    respond_to do |format|
      format.json{ render json: response, status: :unprocessable_entity }
    end
  end

  def respond_to_with_code dict, code

    @e = dict.get_message code
    if @e.nil?
      @e = ErrorDefinition.new 'empty', 'An unspecified error occured saving the message'
    end

    puts 'respond_to_with_code'
    puts code
    respond_to do |format|
      format.json{ render 'api/v1/errors/error_definition_show', :content_type => 'application/json' }
    end

  end


end

class AppsController < AngularController
  respond_to :json, :msgpack
  skip_before_action :verify_authenticity_token

  # App Index - Return paged/unpaged list of user apps
  def index
    if user_signed_in?
      @apps = App.user_apps(current_user)
                  .order_by(:updated_at.desc)
                  .page(params[:page])
                  .per(params[:page_size])

      @pagesize = params[:page_size]
      @page = params[:page]
      respond_to do |format|
        format.json{ render 'apps/index', :content_type => 'application/json' }
      end
    else
      respond_to do |format|
        @notification = { message: 'failure' }
        format.json{ render 'errors/show_base', :content_type => 'application/json', status: :forbidden }
      end
    end
  end

  # PUT
  def edit
    if user_signed_in?
      #do
      @app = App.user_apps(current_user).and(id: params[:id])
      if !@app.nil? and @app.count == 1
        puts 'APP EDIT'
        puts app_update_params
        @app = @app.first
        @app.update_attributes(app_update_params)
        if !params[:message_levels].blank?  #todo this could possible be extracted out
          @app.message_levels = MessageLevel.by_code(params[:message_levels])
        else
          @app.message_levels = nil;
        end

        respond_to do |format|
          format.json{ render 'apps/show', :content_type => 'application/json' }
        end
      else
        respond_to do |format|
          @notification = { message: 'failure' }
          format.json{ render 'errors/show_base', :content_type => 'application/json', status: :forbidden }
        end
      end

    else
      respond_to do |format|
        @notification = { message: 'failure' }
        format.json{ render 'errors/show_base', :content_type => 'application/json', status: :forbidden }
      end
    end
  end

  def new
    @app = App.new
  end

  # POST
  def create


    @user = current_user
    @new_token = SecureRandom.urlsafe_base64(nil, false)

    @app = App.new(app_params.merge(app_token: @new_token))
    @app.user = @user
    @app.message_levels = MessageLevel.all
    puts @app

    if @app.valid? and @app.save
      #success
      respond_to do |format|
        format.json{ render 'apps/show', content_type => 'application/json'}
      end
    else
      @errors = @app.errors
      respond_to do |format|
        format.json{ render 'errors/show_full', :content_type => 'application/json', status: :unprocessable_entity }
      end
    end

  end

  def show
    @app = current_user.apps.find(params[:id])
    #@app_messages = Message.where(:app_id => @app.id).order_by(:created_at.desc)

    if @app.nil?
      respond_to do |format|
        @notification = { message: 'failure' }
        format.json{ render 'errors/show_base', :content_type => 'application/json', status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        format.json{ render 'apps/show', :content_type => 'application/json' }
      end
    end

  end

  private
    def app_params
      params.permit(:name, :hex, :monitor)
    end

  def app_update_params
    params.permit(:name, :hex_color_label, :monitor)
  end
end

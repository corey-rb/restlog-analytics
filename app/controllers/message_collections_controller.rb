class MessageCollectionsController < AngularController
protect_from_forgery except: :create
  def index
    if user_signed_in?

      @collections = []
      if message_list_params[:app_id].blank?
        @collections = MessageCollection.by_user(current_user)
      else
        app = App.user_apps(current_user).find(message_list_params[:app_id])
        if !app.nil?
          @collections = app.message_collections
        end

      end

      respond_to do |format|
        format.json{ render 'message_collections/index', :content_type => 'application/json' }
      end

    else
      respond_to do |format|
        @notification = { message: 'failure' }
        format.json{ render 'errors/show_base', :content_type => 'application/json', status: :forbidden }
      end
    end

  end

  def show
  end

  def create
    #begin
      if user_signed_in?
        #binding.pry
        @collection = MessageCollection.create(save_collection_params)
        puts @collection
        if !message_list_params[:app_id].blank?

          @app = App.user_apps(current_user).find(message_list_params[:app_id])
          puts @app
          if !@app.nil?
            @collection.app = @app
          end
        end
        @collection.user = current_user

        if @collection.valid? and @collection.save
          respond_to do |format|
            format.json{ render 'message_collections/show', :content_type => 'application/json' }
          end
        else
          respond_to do |format|
            @notification = { message: 'collection failed'}
            format.json { render 'errors/show_base', :content_type => 'application/json'}
          end
        end



      else
        #not logged in
      end

    # rescue
    #   respond_to do |format|
    #     @notification = { message: 'failure2' }
    #     format.json{ render 'errors/show_base', :content_type => 'application/json', status: :forbidden }
    #   end
    # end
  end


  private
  def message_list_params
    params.permit(:app_id)
  end

  def save_collection_params
    params.permit(:name, :description, :collection_criteria_property, :criteria_value, :global)
  end
end

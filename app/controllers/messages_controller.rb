class MessagesController < AngularController
  def index
    begin
      if user_signed_in? and !message_params[:app_id].blank?
        #binding.pry
        app = current_user.apps.find(message_params[:app_id])
        if !app.nil?
          @pagesize = !message_params[:page_size].blank? ? message_params[:page_size] : '25'
          @page = !message_params[:page].blank? ? message_params[:page] : '1'
         # binding.pry
          collection = app.get_message_collection(message_params[:collection])
          if !collection.nil?
            collection_query = MongoQueryBuilder.instance.build_message_query_from_message_collection collection
          end

          @messages = app.messages.order_by(:updated_at.desc)
                          .by_query(collection_query)
                          .page(@page)
                          .per(@pagesize)

          if !message_params[:start_date].blank?
            @messages = @messages.created_after(message_params[:start_date])
          end
          if !message_params[:end_date].blank?
            @messages = @messages.created_before(message_params[:end_date])
          end


         respond_to do |format|
              format.json{ render 'messages/index', :content_type => 'application/json'}
          end

        else
          #TODO: return proper error
          respond_to do |format|
            @notification = { message: 'failure' }
            format.json{ render 'errors/show_base', :content_type => 'application/json', status: :forbidden }
          end
        end
      else
        puts 'not signed in'
      end
    rescue Exception => e
      respond_to do |format|
        @notification = { message: 'failure2' }
        format.json{ render 'errors/show_base', :content_type => 'application/json', status: :forbidden }
      end
    end
  end

  private
  def message_params
    params.permit(:app_id, :page_size, :page, :start_date, :end_date, :collection)
  end
end

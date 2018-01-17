require 'time'
class UsersController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def profile
    @user = User.find(current_user.id)
    respond_to do |format|
      format.json{ render 'users/show', content_type => 'application/json'}
    end
  end

  def update
    if !user_signed_in?
      respond_to do |format|
        @notification = { message: 'failure' }
        format.json{ render 'errors/show_base', :content_type => 'application/json', status: :forbidden }
      end
    end

    @user = User.find(current_user.id)

    puts user_billing_params

    @user.build_billing_information(user_billing_params)

    if @user.save
      respond_to do |format|
        format.json{ render 'users/show', content_type => 'application/json'}
      end
    else
      respond_to do |format|
        format.json{ render 'users/show', content_type => 'application/json'}
      end
    end
  end

  def gen_key
    @user = User.find(current_user.id)
    newKey = Base64.encode64(@user.id.to_s + Time.now.to_s)
    @user.account_key = newKey

    if @user.save
       render 'users/show', content_type => 'application/json'
    else
      render 'errors/show_full', content_type => 'application/json'
    end
  end

  def bug_report
    user = User.find(current_user.id)

    print "BUG REPORT SENT with description: " + params[:description]

    UserMailer.bug_report(params[:subject],params[:description])

    render nothing: true
  end

  private
  def user_billing_params
    params.require(:billing_data).permit(:address1, :address2, :first_name, :last_name, :city, :state, :zipcode)
  end
end

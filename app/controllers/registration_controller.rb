class RegistrationController < Devise::RegistrationsController
  def create
    if beta_key_params[:beta_key].present?
      #binding.pry
      key = SignupKey.find_by(:key => beta_key_params[:beta_key])
      if !key.nil? and key.validate_key?
        key.save
        puts key
        super
      else
        flash[:notice] = "Beta key is invalid"
        redirect_to new_user_registration_path
      end
    else
      flash[:notice] = "Beta key is required"
      redirect_to new_user_registration_path
    end
  end

  def update
    super
  end

  def destroy
    super
  end

  def edit
    super
  end

  private
  def beta_key_params
    params.require(:beta).permit(:beta_key)
  end
end

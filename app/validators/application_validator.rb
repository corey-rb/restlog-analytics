class UserApplicationValidator
  def initialize message
    @message = message
  end

  def validate
    if @message.application_id.nil?
      @message.errors[:base] << "Missing Application Id"
    else

    end
  end

end
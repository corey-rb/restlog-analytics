object false

node :errors,:object_root => false do
  @errors.full_messages.map do |err|
    err
  end
end
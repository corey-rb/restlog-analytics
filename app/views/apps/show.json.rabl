object @app
attributes :name,
           :app_token,
           :hex_color_label,
           :updated_at,
           :monitor

node(:id) { |i| i.id.to_s }


node(:message_levels) do |msg|
  concat_array msg.message_levels
end

node(:message_collections) do |collection|

    partial('message_collections/show', :object => collection.message_collections)

end


# child @app_messages, :object_root => false do
#   extends 'messages/show'
# end

def concat_array  items
  simple_array = []
  items.each do |item|
    simple_array.push(item.code)
  end
  return simple_array
end

object @message
attributes :event_data,
           :level

node(:created_at) { |i| i.created_at.strftime('%v %I:%M:%S')}

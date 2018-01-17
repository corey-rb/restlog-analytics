object @collection
attributes :name,
          :description,
          :collection_criteria_property,
          :criteria_value,
          :global
          node(:id) { |i| i.id.to_s }

          node do |msgapp|
            { :app_id => msgapp.app.id.to_s } unless msgapp.app.nil? or msgapp.nil?
          end

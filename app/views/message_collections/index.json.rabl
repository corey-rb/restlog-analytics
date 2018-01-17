object false

child @collections, :object_root => false do
  extends 'message_collections/show'
end

node(:total){ |m| Array(@collections).length }
node(:response){ |m| @collections.size }

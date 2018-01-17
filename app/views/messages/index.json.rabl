object false

node(:total){ |m| Array(@messages).length }
node(:response){ |m| @messages.size }
node(:page) { |m| @page }
node(:page_size){ |m| @pagesize }


child @messages, :object_root => false do
  extends 'messages/show'
end

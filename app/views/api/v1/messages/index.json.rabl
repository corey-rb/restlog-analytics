object false
node(:response) { |m| @messages.length }
node(:page) { |m| '1' }

child(@messages) do
  extends 'api/v1/messages/show'
end
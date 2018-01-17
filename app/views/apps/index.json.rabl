object false


child @apps, :object_root => false do
  extends 'apps/show'
end

node(:total){ |m| @apps.length }
node(:response){ |m| @apps.size }
node(:page) { |m| @page }

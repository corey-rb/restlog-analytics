'use strict';

app.factory('MessageCollection', ['$resource', function($resource){
  return $resource('/messages/collections.json',
  {

  },
{
  update:{
    method: 'PUT'
  }
})
}]);

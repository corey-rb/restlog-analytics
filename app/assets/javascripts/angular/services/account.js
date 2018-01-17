

/*

Get current user, and other settings

 */

'use strict';

app.factory('Account', ['$resource', function($resource){
    return $resource('/user/account/:id.json',
        { id: '@id'},
        {
        current: { method: 'GET' }
    });
}]);
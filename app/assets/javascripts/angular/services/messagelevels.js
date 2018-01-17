/**
 * Created by cschaf on 3/9/15.
 */

app.factory('MessageLevelsService', ['$http', '$resource', function($http, $resource) {

        return $resource('/messagelevels/levels.json', {
            id: '@id'
        },{
            levels: {
                method: 'GET'
            }
        })


}])
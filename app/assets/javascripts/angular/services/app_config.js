app.factory('AppConfig', ['$http', '$resource', function($http, $resource) {

    return {
        appVersion: function (){
            return $http.get('configuration/version.json');
        }
    }
}]);

'use strict';



app.factory('Apps', ['$resource', function($resource){
    return $resource('/user/apps/:id.json',
        {
            id: '@id'
        },
        {
            update: {
                method: 'PUT'
            },
            'userApps': {
                method: 'GET'
            }
        }
    );
}]);

app.factory('AppInfo', ['$http', '$resource', function($http,$resource) {
    return {
        appData : function (appId) {
            return $http.get('message_analytics/app_data', {params: {app_id: appId}});
        },
        messagesByLevel : function (startDate,endDate) {
            return $http.get('message_analytics/app/messages_by_level/',{});
        },
        messagesByDay : function (startDate,endDate) {
            return $http.get('message_analytics/app/messages_by_day/',{});
        }
    }
}]);

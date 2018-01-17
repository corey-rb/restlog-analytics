'use strict';

app.factory('UserProfile', ['$resource', function($resource){
    return $resource('/users/profile.json',
        {
            id: '@id'
        },
        {
            update: {
                method: 'PUT'
            }
        }
    );

}]);

app.factory('UserData', ['$http', '$resource', function($http, $resource){
    return {
        newAccountKey : function () {
            return $http.get('users/generate_key/', {});
        }
    }

}]);

app.factory('UserBugReport', ['$http', '$resource', function($http, $resource) {
    return {
        submitBugReport : function (bugReport) {
            return $http.get('bug_report/', {params: {subject: bugReport.subject, description: bugReport.description}});
        }
    }
}])
'use strict';

app.controller('ProfileCtrl', ['$http', '$scope', '$state', 'Apps', 'UserProfile', 'UserData',
    function($http, $scope, $state, Apps, UserProfile, UserData){

        Apps.userApps().$promise.then(
            function(success){
                $scope.apps = success.apps;
            },
            function(err){
                console.log('error getting apps');
            });

        UserProfile.get().$promise.then(
            function(success) {
                $scope.user = success;
            },
            function(err) {
                console.log('error getting user data');
            }
        )

}]);

app.controller('UserBillingDataCtrl', ['$http', '$scope', '$state', 'Apps', 'User', 'UserProfile',
    function($http, $scope, $state, Apps, User, UserProfile){

        UserProfile.get().$promise.then(
            function(success) {
                $scope.user = success;
            },
            function(err) {
                console.log('error getting user data');
            }
        )
        //$scope.user = new UserData();
        $scope.updateBilling = function(user){
            /*User.update(function(user) {
                //success
                console.log(user);
                $state.go('restlog.profile');
            }, function(err) {
                var errors = angular.fromJson(err.data.errors);
                console.log(errors);
                //$scope.errors.push(errors);
            })*/
            UserProfile.update(user)
                .$promise.then(
                function(value){
                    $state.go('restlog.profile');
                }, function(err){
                    var errors = angular.fromJson(err.data.errors);
                    $scope.errors = [];
                    $scope.errors.push(errors);
                }
            )
        }


    }]);

app.controller('UserConfirmUpdateKeyCtrl', ['$http', '$scope', '$state', 'Apps', 'User', 'UserData',
    function($http, $scope, $state, Apps, User, UserData){

    $scope.confirmNewAccountKey = function() {
        UserData.newAccountKey()
            .then(
            function(value) {
                $state.go("restlog.profile");
            }, function(err) {
                console.log("error: " + err);
            }
        )
    }

}]);

app.controller('UserBugReportCtrl', ['$http', '$scope', '$state', 'UserBugReport',
    function($http, $scope, $state, UserBugReport) {
        $scope.submitBugReport = function(bugReport) {
            console.log("sending bug report " + bugReport.description);
            UserBugReport.submitBugReport(bugReport)
                .then(
                    function(value) {
                        $state.go("restlog.dashboard");
                    }, function(err) {
                        console.log("Error" + err);
                    }
                )
        }

}]);

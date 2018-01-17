/**
 * Created by cschaf on 10/23/14.
 */

'use strict';

app.controller('RestlogMasterV1Ctrl', ['$http', '$scope', 'MessageService', '$window', 'Apps', 'Account', 'AppConfig',
    function($http, $scope, MessageService, $window, Apps, Account, AppConfig){

        Account.current().$promise.then(
            function(succ){
              $scope.username = succ.email;

            }, function(err){
                $scope.username = 'ERR';
            }
        );

        // our top apps
        Apps.userApps({page: '1', page_size: '5'}).$promise.then(
            function(success){
                $scope.userApps = success.apps;
                $scope.totalAppCount = success.total;
                console.log($scope.userApps);
            },
            function(err){
                console.log('error getting apps, master controller');
            });


        // This updates our side nav when we add a new app
        $scope.$on('saveUserApp', function(event, value){
            console.log('message recieved');
            //$scope.$apply(function(){
                Apps.userApps({page: '1', page_size: '5'}).$promise.then(
                    function(success){
                        $scope.userApps = success.apps;
                        $scope.totalAppCount = success.total;
                        console.log($scope.userApps);
                    },
                    function(err){
                        console.log('error getting apps, master controller');
                    });
            //});
        });



        // add 'ie' classes to html
        var isIE = !!navigator.userAgent.match(/MSIE/i);
        isIE && angular.element($window.document.body).addClass('ie');
        isSmartDevice( $window ) && angular.element($window.document.body).addClass('smart');


        $scope.app = {
            name: 'Restlog',
            //chart colors
            color: {
                primary: '#7266ba',
                info:    '#23b7e5',
                success: '#27c24c',
                warning: '#fad733',
                danger:  '#f05050',
                light:   '#e8eff0',
                dark:    '#3a3f51',
                black:   '#1c2b36'
            },
            settings: {
                themeID: 1,
                navbarHeaderColor: 'bg-black',
                navbarCollapseColor: 'bg-white-only',
                asideColor: 'bg-black',
                headerFixed: true,
                asideFixed: false,
                asideFolded: false,
                asideDock: false,
                container: false
            }
        }

        AppConfig.appVersion().then(
            function(data){
                $scope.app.version = data.data.version;
            },
            function(err){
                $scope.app.version = "err";
            }
        )

        //MessageService.searchMessages("","","","",25)
        //    .then(function(data) {
        //        //console.log(data.data);
        //        $scope.messages = data.data;
        //    }, function(error) {
        //        console.log('error: ', error);
        //    });
        //
        //$scope.getUserMessages = function() {
        //    MessageService.userApps().
        //        success(function(response) {
        //            $scope.apps = response.apps;
        //            //console.log(response);
        //        }).
        //        error(function(err) {
        //            console.log("error getting messages. " + err);
        //        });
        //}

        function isSmartDevice( $window )
        {
            // Adapted from http://www.detectmobilebrowsers.com
            var ua = $window['navigator']['userAgent'] || $window['navigator']['vendor'] || $window['opera'];
            // Checks for iOs, Android, Blackberry, Opera Mini, and Windows mobile devices
            return (/iPhone|iPod|iPad|Silk|Android|BlackBerry|Opera Mini|IEMobile/).test(ua);
        }
 }]);

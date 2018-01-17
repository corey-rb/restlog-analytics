
'use strict';

app.controller('AppIndexCtrl', ['$http', '$scope', 'Apps',
    function($http, $scope, Apps){

     Apps.userApps().$promise.then(
         function(success){
            $scope.apps = success.apps;
            // console.log(success);
     },
         function(err){
             console.log('error getting apps');
         });


}]);

// App View/Detail Controller
//
//
//
app.controller('AppViewCtrl', ['$http', '$scope', 'Apps', 'MessageService', '$stateParams', 'MessageCollection', '$rootScope',
    function($http, $scope, Apps, MessageService, $stateParams, MessageCollection, $rootScope){





    $scope.searchQuery = {
      page: '1',
      page_size: '50',
      message_type: ''
    };

    $scope.app = Apps.get( { id: $stateParams.id }, function(app){
        $scope.app = app;
        $scope.c = new MessageCollection();
        $scope.c.app_id  = $scope.app.id;

        MessageService.messagesByApp($scope.app.id, '50', '1')
          .then(
            function(data){
                console.log(data);
                $scope.messages = angular.fromJson(data.messages);
                var response_meta = {};
                response_meta.results = data.total;
                response_meta.total = data.response;
                $scope.data_response_meta = response_meta;

                $scope.properties = parse_messages($scope.messages);
                console.log($scope.properties);

            },function(err){
              console.log(err);
            });
    });

    $scope.searchMessages = function(searchQuery){
      console.log(searchQuery);
      console.log($scope.searchQuery);
      $scope.messages = {};
      MessageService.messagesByApp($scope.app.id, $scope.searchQuery.page_size, '1', $scope.searchQuery.collection)
        .then(
          function(data){
              console.log(data);
              $scope.messages = angular.fromJson(data.messages);
              var response_meta = {};
              response_meta.results = data.total;
              response_meta.total = data.response;
              $scope.data_response_meta = response_meta;
          },function(err){
            console.log(err);
          });

    };

    $scope.saveCollection = function(newCol){
      console.log('in saveCollection');
      console.log($scope.c);

      if($scope.c && $scope.c.collection_criteria_property){

        $scope.c.$save(function(val){
          $rootScope.$broadcast('saveMessageCollection', $scope.c);
          $scope.c = new MessageCollection();
        },function(err){
          console.log(err);
        });

      }

    };

    //listen for the new message collection aded
    $scope.$on('saveMessageCollection', function(event, args){
      console.log('$on for - saveMessageCollection');
      console.log(event);
      console.log(args);
      $scope.app.message_collections.push(args);
    });



}]);

// POST New App
app.controller('RestlogAppNewCtrl', ['$http', '$scope', 'Apps','$stateParams', '$state', '$rootScope',
    function($http, $scope, Apps, $stateParams, $state, $rootScope){

        $scope.app = new Apps();

        $scope.errors = [];

       // $scope.app.app_token =  Math.random().toString(36).substring(5);

        $scope.addApp = function(){
            $scope.app.$save(function(value){
                //success
                console.log('new app')
                console.log(value);
                $rootScope.$broadcast('saveUserApp', value);
                $state.go('restlog.appIndex');
            }, function(err){
                var errors = angular.fromJson(err.data.errors);
                $scope.errors.push(errors);
            });
        }


}]);

// PUT edit app
app.controller('AppEditCtrl', ['$scope', '$state', '$stateParams', 'Apps', 'MessageLevelsService',
    function($scope, $state, $stateParams, Apps, MessageLevelsService){

        MessageLevelsService.levels().$promise.then(
            function(success){
                $scope.log_levels = success.message_levels;
                //console.log($scope.log_levels);
            },function(err){

            }
        );

        $scope.errors = [];

        $scope.userApp = Apps.get({ id: $stateParams.id }, function(userApp){
            $scope.userApp = userApp;

        });

        // level check boxes
        $scope.checkAll = function(){
            $scope.userApp.message_levels = $scope.log_levels.map(function(level) { return level.code; });
        };

        $scope.uncheckAll = function(){
          $scope.userApp.message_levels = [];
        };

        $scope.updateApp = function(userApp){
            Apps.update(userApp)
                .$promise.then(
                function(value){
                    $state.transitionTo('restlog.appView', $stateParams);
                }, function(err){
                    var errors = angular.fromJson(err.data.errors);
                    $scope.errors = [];
                    $scope.errors.push(errors);
                }
            )
        }

    }]);

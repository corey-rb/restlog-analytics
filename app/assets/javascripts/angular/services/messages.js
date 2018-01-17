
app.factory('MessageService', ['$http', '$resource', function($http, $resource) {

    return {
      // returns message count per app of today, max 5 apps
        dailyMessageCount: function (){
            return $http.get('message_analytics/dailyappscount.json', {
                params: {

                }
            });
        },
        recentMessages : function (lastUpdate) {
            return $http.get('message_analytics/new_messages.json', {params: {lastUpdate: lastUpdate}})
        },
        messagesByApp : function (app_id, pageSize, pageNumber, collection_id) {

          //var deferred = $q.defer();
          return $http.get('app/messages.json',
          {
            params: {
                app_id: app_id,
                page_size: pageSize,
                page: pageNumber,
                collection: collection_id
            }
          }
          ).then(function(rsp){
            return rsp.data;
          });

        }


    }

}]);

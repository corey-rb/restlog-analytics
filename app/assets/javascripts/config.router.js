'use strict';

/**
 * Created by cschaf on 12/15/14.
 */

app.run(['$rootScope', '$state', '$stateParams',  function($rootScope, $state, $stateParams){
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;

    // TODO: look into q.defered
    $state.go('restlog.dashboard');


    //$rootScope.$on('$stateChangeError', function(event, toState, fromState, fromParams, error){
    //    console.log(error);
    //});

}])
.config(['$stateProvider', '$urlRouterProvider', '$locationProvider',
            function ($stateProvider,$urlRouterProvider, $locationProvider){

             //   $locationProvider.html5Mode(true);


                $urlRouterProvider.otherwise('/dashboard');

                $stateProvider

                    // core routes
                    .state('loading', {
                        url: '/loading',
                        templateUrl: 'load.html'
                    })
                    .state('404',{
                        url: '/404',
                        templateUrl: '404.html'
                    })

                    // User Dashboard
                    .state('restlog',{
                        abstract: true,
                        templateUrl: 'restlog/abstract-template.html'
                    })
                    .state('restlog.dashboard', {
                        url: '/dashboard',
                        templateUrl: 'restlog/dashboard-v1.html'//,
                        //controller: 'restlogDashboardCtrl'
                    })
                    // User defined apps
                    .state('restlog.appIndex', {
                        url: '/apps/index.html',
                        templateUrl: 'restlog/apps/index.html',
                        controller: 'AppIndexCtrl'
                    })
                    .state('restlog.appNew', {
                        url: '/apps/new.html',
                        templateUrl: 'restlog/apps/new.html',
                        controller: 'RestlogAppNewCtrl'
                    })
                    .state('restlog.appView',{
                        url: '/apps/view/:id',
                        controller: 'AppViewCtrl',
                        templateUrl: 'restlog/apps/show.html'
                    })
                    .state('restlog.appEdit', {
                        url: '/apps/edit/:id',
                        controller: 'AppEditCtrl',
                        templateUrl: 'restlog/apps/edit.html'
                    })
                    .state('restlog.profile', {
                        url: '/user/profile.html',
                        templateUrl: 'restlog/user/profile.html',
                        controller: 'ProfileCtrl'
                    })
                    .state('restlog.confirmAccountKey', {
                        url: '/user/new-account-key-confirm.html',
                        templateUrl: 'restlog/user/new-account-key-confirm.html',
                        controller: 'UserConfirmUpdateKeyCtrl'
                    })
                    .state('restlog.userBilling', {
                        url: '/user/billing.html',
                        templateUrl: 'restlog/user/billing-data-form.html',
                        controller: 'UserBillingDataCtrl'
                    })

                    .state('restlog.404',{
                        url: '/404/',
                        templateUrl: '404'
                    })

                    .state('restlog.account', {
                        url: '/account',
                        templateUrl: 'restlog/account',
                        controller: 'UserAccountCtrl'
                    })

                    .state('restlog.reportBug', {
                        url: '/bugreport',
                        templateUrl: 'restlog/user/bug-report-form.html',
                        controller: 'UserBugReportCtrl'
                    })



                // FIX for trailing slashes, from https://github.com/angular-ui/ui-router/issues/50
                //$urlRouterProvider.rule(function($injector, $location) {
                //    if($location.protocol() === 'file')
                //        return;
                //
                //    var path = $location.path()
                //    // Note: misnomer. This returns a query object, not a search string
                //        , search = $location.search()
                //        , params
                //        ;
                //
                //    // check to see if the path already ends in '/'
                //    if (path[path.length - 1] === '/') {
                //        return;
                //    }
                //
                //    // If there was no search string / query params, return with a `/`
                //    if (Object.keys(search).length === 0) {
                //        return path + '/';
                //    }
                //
                //    // Otherwise build the search string and return a `/?` prefix
                //    params = [];
                //    angular.forEach(search, function(v, k){
                //        params.push(k + '=' + v);
                //    });
                //    return path + '/?' + params.join('&');
                //});

    }]);

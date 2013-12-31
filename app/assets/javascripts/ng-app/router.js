angular.module("MyApp").config(function($stateProvider, $urlRouterProvider) {
    //
    // For any unmatched url, redirect to /state1
    $urlRouterProvider.otherwise("/");
    //
    // Now set up the states
    $stateProvider
        .state('coolThings', {
            url: "/",
            templateUrl: "ng-app/templates/coolThings.html",
            controller: "CoolThingsCtrl"
        })
});

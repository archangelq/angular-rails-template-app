angular.module('MyApp').config([
  '$stateProvider',
  '$urlRouterProvider',
  function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/');
    $stateProvider.state('coolThings', {
      url: '/',
      templateUrl: 'ng-app/templates/coolThings.html',
      controller: 'CoolThingsCtrl'
    });
  }
]);
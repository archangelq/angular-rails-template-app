angular.module('MyApp.controllers').controller('CoolThingsCtrl', [
  '$scope',
  'CoolThings',
  function ($scope, CoolThings) {
    $scope.coolThings = [];
    CoolThings.query().then(function (coolThings) {
      $scope.coolThings = coolThings;
    });
    $scope.isCollapsed = false;
  }
]);
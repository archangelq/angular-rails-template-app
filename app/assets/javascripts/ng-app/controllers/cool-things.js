angular.module("MyApp.controllers").controller("CoolThingsCtrl", function($scope, CoolThings){
    $scope.coolThings = []
    CoolThings.query().then(function(coolThings){ $scope.coolThings = coolThings})
    $scope.isCollapsed = false;
})
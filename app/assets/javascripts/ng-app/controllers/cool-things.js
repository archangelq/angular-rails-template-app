angular.module("MyApp.controllers").controller("CoolThingsCtrl", function($scope){
    $scope.coolThings = [
        {name: "AngularJS", language: "Javascript"},
        {name: "Rails", language: "Ruby"}
    ]
    $scope.isCollapsed = false;
})
describe("CoolThingsCtrl", function(){
    var $scope = null
    var ctrl = null
    var q = null
    var deferred = null

    var coolThingsMock = {
        query: function(queryString){
            deferred = q.defer()
            return deferred.promise
        },
        resolve: function(obj){
            deferred.resolve(data)
            $scope.$apply()
        }
    }


    beforeEach(angular.mock.module('MyApp'))
    beforeEach(angular.mock.inject(function($rootScope, $controller, $q) {
        //create a scope object for us to use.
        $scope = $rootScope.$new()
        q = $q

        //now run that scope through the controller function,
        //injecting any services or other injectables we need.
        ctrl = $controller('CoolThingsCtrl', {
            $scope: $scope,
            CoolThings: coolThingsMock
        })
    }))

    it("should start with an empty array for $scope.coolThings", function(){
        expect($scope.coolThings).toEqual([])
    })

    it("should have $scope.coolThings populated when the promise resolves", function(){
        expect($scope.coolThings).toEqual([])
        data = [{name: "Testing", language: "jasmine"}]
        coolThingsMock.resolve(data)
        expect($scope.coolThings).toEqual(data)
    })

})
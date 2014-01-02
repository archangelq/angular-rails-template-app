angular.module("MyApp.services").factory('CoolThings',
    function(railsResourceFactory){
        return railsResourceFactory({
            url: "/cool-things",
            name: "coolThings"
        })
    })
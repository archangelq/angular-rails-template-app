describe("CoolThings", function(){
    var svc = null
    var http = null

    beforeEach(function(){
        module("MyApp")
        inject(function($httpBackend, CoolThings){
            http = $httpBackend
            svc = CoolThings
        })
    })

    afterEach(function() {
        http.verifyNoOutstandingExpectation();
        http.verifyNoOutstandingRequest();
    });

    it('should have a query function', function () {
        expect(angular.isFunction(svc.query)).toBe(true);
    });

    it('should call /cool-things when you query', function(){
        data = [{name: "mocks", language: "javascript"}]
        http.expectGET('/cool-things').respond(data)

        svc.query().then(function(svcdata){
            expect(svcdata.length).toEqual(data.length)
            expect(svcdata[0].name).toEqual(data[0].name)
            expect(svcdata[0].language).toEqual(data[0].language)
        })

        http.flush()
    })

})
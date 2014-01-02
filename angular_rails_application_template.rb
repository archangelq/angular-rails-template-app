application "config.angular_templates.module_name = \"#{app_name}App.templates\""
application "#Templates module name for rails_angular_templates. Also used in app/assets/javascripts/ng-app/ng-app.js.erb"

route 'root to: "application#index"'
route 'get "/cool-things", to: "application#cool_things"'

#Rails includes
run "rm app/views/layouts/application.html.erb"
file "app/views/layouts/application.html.erb", <<-eof
<!DOCTYPE html>
<html ng-app="MyApp">
<head>
  <title>Angular Rails Template</title>



  <%= stylesheet_link_tag    "application", :media => "all" %>
  <%= javascript_include_tag "application" %>
  <%= csrf_meta_tags %>
</head>
<body>

<%= yield %>

</body>
</html>

eof
run "rm app/views/application/index.html.erb"
file "app/views/application/index.html.erb", <<-eof
<div ui-view>
</div>
eof
run "rm app/controllers/application_controller.rb"
file "app/controllers/application_controller.rb", <<-eof
class ApplicationController < ActionController::Base
  protect_from_forgery
  def index
  end

  def cool_things
    respond_to do |format|
      format.any do
        render :json => [{name: "AngularJS", language: "Javascript"},
                         {name: "Rails", language: "Ruby"},
                         {name: "Bootstrap", language: "Less (CSS)"}]
      end
    end
  end
end

eof
run "rm README.md"
file "README.md", <<-eof
# Elvis Sandwich #
## Rails, AngularJS, and Bootstrap go together like peanut butter, banana and bacon ##

Want to get working with Rails, AngularJS, and Bootstrap quick and easy? Don't want to have to worry
 about getting your angular app working with the asset pipeline? Here's the place to get started.

If you haven't already, create your new app like so:

```
rails new myapp -T -m https://raw.github.com/archangelq/elvis_sandwich/master/angular_rails_application_template.rb
```

Fire up your new app with `rails server`, go to localhost:3000, and you should be presented with
 this readme, as well as some simple output from your running AngularJS app, listing the cool stuff
 you have installed and working!

All of the Angular code lives in the `app/assets/javascripts/ng-app` folder.
 If you are reading this file from your newly created app, you are reading the output
 of `templates/coolThings.html.erb` file. Start making modifications to it, reload your browser,
 and you should see them show up!

This template also includes the very useful
[`ui-router`](https://github.com/angular-ui/ui-router) and
[`ui-bootstrap`](http://angular-ui.github.io/bootstrap/) angular module, as well as the
[`angular-rails-template`](https://github.com/dmathieu/angular-rails-templates) gem.

In order to load the templates that the gem inlines for you from the ui-router, you'll
 need have the url be `ng-app/templates/<template_filename>`, rather than simply
 `<template_filename>`, due to the way that Rails' Asset Pipeline works. Note that this
 allows you to add .erb on to the end of files, and have it be processed by ERB before
 being streamlined into the templateCache, as well as any of the other things you can do with
 the Rails asset pipeline, including using Coffeescript, Haml, etc.

Happy Coding!

### Caveats ###
This template assumes you are starting a new app. It removes certain conflicting files,
such as the ApplicationController and application layout files.
eof
run "rm public/index.html"

#Gems
gem 'bootstrap-sass', '~> 3.0.3.0'
gem 'angular-rails-templates'
gem 'github-markdown'
gem 'angularjs-rails-resource', '~> 0.2.3'


gem_group :development, :test do
  gem "rspec-rails"
  gem "pry"
  gem "pry-nav"
end

gem_group :test do
  gem "cucumber-rails", require: false
end

generate("rspec:install")
generate("cucumber:install")

#Javascript stuff
run "rm app/assets/javascripts/application.js"
file "app/assets/javascripts/application.js", <<-eof
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//= require jquery
//= require jquery_ujs
//= require angular/angular
//= require angular-ui-router/release/angular-ui-router
//= require angular-bootstrap/ui-bootstrap-tpls
//= require angularjs/rails/resource
//= require ng-app/ng-app
//= require_tree .

eof
run "rm app/assets/javascripts/ng-app/router.js"
file "app/assets/javascripts/ng-app/router.js", <<-eof
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

eof
run "rm app/assets/javascripts/ng-app/controllers/cool-things.js"
file "app/assets/javascripts/ng-app/controllers/cool-things.js", <<-eof
angular.module("MyApp.controllers").controller("CoolThingsCtrl", function($scope, CoolThings){
    $scope.coolThings = []
    CoolThings.query().then(function(coolThings){
        $scope.coolThings = coolThings
    })
    $scope.isCollapsed = false;
})
eof
run "rm app/assets/javascripts/ng-app/services/cool-things.js"
file "app/assets/javascripts/ng-app/services/cool-things.js", <<-eof
angular.module("MyApp.services").factory('CoolThings',
    function(railsResourceFactory){
        return railsResourceFactory({
            url: "/cool-things",
            name: "coolThings"
        })
    })
eof
run "rm app/assets/javascripts/ng-app/ng-app.js.erb"
file "app/assets/javascripts/ng-app/ng-app.js.erb", <<-eof
angular.module("MyApp.services",['rails'])
angular.module("MyApp.controllers",["MyApp.services"])
angular.module("MyApp",["ui.bootstrap","ui.router","MyApp.controllers", "<%= Rails.application.config.angular_templates.module_name %>"])
eof
run "rm app/assets/javascripts/ng-app/templates/coolThings.html.erb"
file "app/assets/javascripts/ng-app/templates/coolThings.html.erb", <<-eof
<div class="jumbotron">
<!-- Super simple Angular example code -->
<h3>The cool things you have installed in your app are:</h3>

<ul ng-repeat="coolThing in coolThings">
    <li>{{coolThing.name}}, written in {{coolThing.language}}</li>
</ul>

<!-- Intro Readme: remove me first -->
  <button class="btn btn-default" ng-click="isCollapsed = !isCollapsed">Hide/Show Readme</button>
  <hr>
  <div collapse="isCollapsed">
    <%= GitHub::Markdown.render_gfm(File.read(Rails.root.join('README.md'))) %>
  </div>


</div>
eof

#CSS
run "rm app/assets/stylesheets/application.css"
file "app/assets/stylesheets/application.css", <<-eof
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,
 * or vendor/assets/stylesheets of plugins, if any, can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the top of the
 * compiled file, but it's generally better to create a new file per style scope.
 *
 *= require_self
 *= require_tree .
 *= require bootstrap/bootstrap
 *= require bootstrap/bootstrap-theme
 */
eof
run "mkdir -p vendor/assets/stylesheets/bootstrap"
run "curl http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.css -o ./vendor/assets/stylesheets/bootstrap/bootstrap.css"
run "curl http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.css -o ./vendor/assets/stylesheets/bootstrap/bootstrap-theme.css"

#Testing stuff
run "rm lib/karma_config.js.erb"
file "lib/karma_config.js.erb", <<-eof
module.exports = function (config) {
    config.set({
        basePath: '<%= root %>',

        frameworks: ["jasmine"],

        files: <%= files %>,
        exclude : [],
        autoWatch : <%= !opts[:single_run] %>,
        browsers: ['Chrome'],
        singleRun: <%= !!opts[:single_run] %>,
        reporters: ['progress'],
        port: 9876,
        runnerPort: 9100,
        colors: true,
        logLevel: config.LOG_INFO,
        proxies: <%= opts[:proxies].to_json %>,
        urlRoot: '/__karma__/',
        captureTimeout: 60000
    });
}
eof
run "rm lib/karma.rb"
file "lib/karma.rb", <<-eof
module Karma
  def self.files
    @files ||= [
        "vendor/assets/javascripts/angular-mocks/angular-mocks.js",
        "spec/javascripts/**/*.js"
    ]
  end

  def self.root()
    File.join(File.dirname(__FILE__),"..")
  end

  def self.config(opts = {})
    opts[:proxies] ||= []
    b = binding
    ERB.new(File.read(File.join(root,"lib/karma_config.js.erb"))).result(b)
  end

  def self.start!(opts = {})
    Dir.mktmpdir(nil,File.join(root,"tmp/test")) do |dir|
      confjs = File.join(dir, "karma.conf.js")

      opts[:extra_files].each do |filename,content|
        fullpath = File.join(dir,filename)
        File.open(fullpath, "w") do |f|
          f.write(content)
        end
        files.unshift fullpath
      end

      File.open(confjs, "w") do |f|
        f.write config(opts)
      end

      system "karma start " + confjs #Explicitly not using string interp here
    end
  end
end
eof
run "rm lib/karma_unit.rb"
file "lib/karma_unit.rb", <<-eof
require File.join(File.dirname(__FILE__),"karma")

module Karma
  class Unit
    def self.test!(opts = {})
      sprockets = Rails.application.assets

      opts[:extra_files] = {
          "application.js" => sprockets.find_asset("application.js").to_s
      }

      Karma.start!(opts)
    end
  end
end
eof
run "rm lib/tasks/karma.rake"
file "lib/tasks/karma.rake", <<-eof
namespace :test do
  task :karma => :"karma:run"

  namespace :karma do
    desc "Run all karma tests"

    task :once => :environment do
      require Rails.root.join("lib", "karma_unit")
      puts "--> Running karma unit tests"
      Karma::Unit.test!(:single_run => true)
    end

    desc "Run unit tests (test/karma/unit)"
    task :run => :environment do
      require Rails.root.join("lib", "karma_unit")
      Karma::Unit.test!
    end
  end
end

eof
run "rm spec/javascripts/controllers/coolThingsCtrlSpec.js"
file "spec/javascripts/controllers/coolThingsCtrlSpec.js", <<-eof
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


    beforeEach(module('MyApp'))
    beforeEach(inject(function($rootScope, $controller, $q) {
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
eof
run "rm spec/javascripts/services/coolThingsSpec.js"
file "spec/javascripts/services/coolThingsSpec.js", <<-eof
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
eof
run 'mkdir -p tmp/test'

#Bower and external JS requirements
run "rm package.json"
file "package.json", <<-eof
{
  "name": "yom-angularjs-testing-article",
  "version": "0.0.0",
  "repository": {
    "type": "git",
    "url": "https://github.com/matsko/YOM-AngularJS-Testing-Article"
  },
  "scripts": {
    "postinstall": "./node_modules/.bin/bower install"
  },
  "homepage": "https://github.com/yearofmoo/YOM-AngularJS-Testing-Article",
  "devDependencies": {
    "grunt": "~0.4.1",
    "grunt-css": "~0.5.4",
    "grunt-contrib-connect": "~0.1.2",
    "grunt-contrib-uglify": "~0.2.1",
    "grunt-contrib-concat": "~0.3.0",
    "grunt-contrib-watch": "~0.4.4",
    "grunt-shell": "~0.2.2",
    "grunt-contrib-copy": "~0.4.1",
    "karma-mocha": "latest",
    "karma-chrome-launcher": "~0.1.0",
    "karma-safari-launcher": "latest",
    "karma-firefox-launcher": "~0.1.0",
    "karma-ng-scenario": "latest",
    "chai": "1.4.0",
    "karma-script-launcher": "~0.1.0",
    "karma-html2js-preprocessor": "~0.1.0",
    "karma-jasmine": "~0.1.3",
    "karma-requirejs": "~0.1.0",
    "karma-coffee-preprocessor": "~0.1.0",
    "karma-phantomjs-launcher": "~0.1.0",
    "karma": "~0.10.2",
    "grunt-karma": "~0.6.2",
    "grunt-open": "~0.2.2",
    "ng-midway-tester": "2.0.5",
    "bower": "~1.2.7"
  }
}

eof
run "rm .bowerrc"
file ".bowerrc", <<-eof
{
	"directory": "vendor/assets/javascripts"
}
eof
run "rm bower.json"
file "bower.json", <<-eof
{
    "name": "MyApp",
    "version": "0.0.0",
    "authors": [
        ""
    ],
    "dependencies": {
        "angular": "~1.2.0",
        "angular-ui-router": "~0.2.7",
        "angular-bootstrap": "~0.9.0",
        "angular-mocks": "~1.2.0"
    },
    "private": true
}
eof

run "npm install" #Automatically runs bower install

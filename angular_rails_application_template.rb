
"TESTING"

application "config.angular_templates.module_name = \"#{app_name}App.templates\""
application "#Templates module name for rails_angular_templates. Also used in app/assets/javascripts/ng-app/ng-app.js.erb"

route 'root to: "application#index"'

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

end

eof
run "rm README.md"
file "README.md", <<-eof
      # AngularJS + Rails #
## You got chocolate chips in my silicon chips! ##

This is a simple cloneable Rails application to be used as a template for other
eof
run "rm public/index.html"

#Javascript stuff
gem "angular-rails-templates"

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
      angular.module("MyApp.controllers").controller("CoolThingsCtrl", function($scope){
    $scope.coolThings = [
        {name: "AngularJS", language: "Javascript"},
        {name: "Rails", language: "Ruby"}
    ]
})
eof
run "rm app/assets/javascripts/ng-app/ng-app.js.erb"
file "app/assets/javascripts/ng-app/ng-app.js.erb", <<-eof
      angular.module("MyApp.services",[])
angular.module("MyApp.controllers",["MyApp.services"])
angular.module("MyApp",["ui.router","MyApp.controllers", "<%= Rails.application.config.angular_templates.module_name %>"])
eof
run "rm app/assets/javascripts/ng-app/templates/coolThings.html"
file "app/assets/javascripts/ng-app/templates/coolThings.html", <<-eof
      <h3>The cool things you have installed in your app are:</h3>
<ul ng-repeat="coolThing in coolThings">
    <li>{{coolThing.name}}, written in {{coolThing.language}}</li>
</ul>
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
  "name": "angular_rails_application_template",
  "version": "0.0.0",
  "authors": [
    "Hunter Thomas <archangelq@gmail.com>"
  ],
  "dependencies": {
    "angular": "~1.2.0",
    "angular-ui-router": "~0.2.7"
  },
  "private": true,
  "ignore": [
    "**/.*",
    "node_modules",
    "bower_components",
    "vendor/assets/javascripts",
    "test",
    "tests"
  ]
}

eof
run "bower install"


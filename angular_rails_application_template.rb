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
      # Elvis Sandwich #
## Rails, AngularJS, and Bootstrap go together like peanut butter, banana and bacon ##

Want to get working with Rails, AngularJS, and Bootstrap quick and easy? Don't want to have to worry
 about getting your angular app working with the asset pipeline? Here's the place to get started.

If you haven't already, create your new app like so:

```
rails new myapp -m https://raw.github.com/archangelq/elvis_sandwich/master/angular_rails_application_template.rb
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
//= require angular-bootstrap/ui-bootstrap
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
    $scope.isCollapsed = false;
})
eof
run "rm app/assets/javascripts/ng-app/ng-app.js.erb"
file "app/assets/javascripts/ng-app/ng-app.js.erb", <<-eof
      angular.module("MyApp.services",[])
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


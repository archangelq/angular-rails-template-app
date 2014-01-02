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
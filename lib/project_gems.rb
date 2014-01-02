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
#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

module CompileHelpers
  def project_file(file)
    File.read(File.join(File.dirname(__FILE__),file))
  end

  def insert(file)
    "run \"rm #{file}\"
file \"#{file}\", <<-eof
      #{project_file(file)}
eof"
  end
end

AngularRailsApplicationTemplate::Application.load_tasks

task :compile_template_rb do
  include CompileHelpers
  b = binding
  File.open("angular_rails_application_template.rb", "w+") do |f|
    f.write(ERB.new(project_file("angular_rails_application_template.rb.erb")).result(b))
  end
end
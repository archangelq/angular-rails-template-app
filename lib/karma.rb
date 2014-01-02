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
    proxies = "proxies : #{opts[:proxy].to_json}," if opts[:proxy]
    proxies ||= ""

    config_file = <<-EOC
          module.exports = function (config) {
            config.set({
              basePath : '#{root}',

              frameworks : ["jasmine"],

              files : #{files},
              exclude : [],
              autoWatch : #{!opts[:single_run]},
              browsers : ['Chrome'],
              singleRun : #{!!opts[:single_run]},
              reporters : ['progress'],
              port : 9876,
              runnerPort : 9100,
              colors : true,
              logLevel : config.LOG_INFO,
              #{proxies}
              urlRoot : '/__karma__/',
              captureTimeout : 60000
            });
          }
    EOC
    config_file
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

      system "karma start #{confjs}"
    end
  end
end
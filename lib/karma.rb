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
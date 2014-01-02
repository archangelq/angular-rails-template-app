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
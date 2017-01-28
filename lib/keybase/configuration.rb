require "json"

module Keybase
  module Configuration
    CONFIG_DIR = File.expand_path("~/.config/keybase").freeze

    CONFIG_FILE = File.join(CONFIG_DIR, "config.json").freeze

    CONFIG_HASH = JSON.parse(File.read(CONFIG_FILE)).freeze

    def current_user
      CONFIG_HASH["current_user"]
    end

    def users
      CONFIG_HASH["users"].map { |_, v| Keybase::User.new(v) }
    end

    def private_dir
      "/keybase/private/#{current_user}"
    end

    def public_dir
      "/keybase/public/#{current_user}"
    end

    def running?
      # is there a more efficient way to do this that doesn't involve an exec?
      Dir["/proc/[0-9]*/comm"].any? do |comm|
        File.read(comm).chomp == "keybase"
      end
    end

    def running_version
      raise KeybaseNotRunningError unless Keybase.running?
      `keybase --version`.split[2]
    end
  end
end

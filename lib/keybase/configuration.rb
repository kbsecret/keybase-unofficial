# frozen_string_literal: true

require "json"

module Keybase
  # Methods and constants related to a local Keybase installation.
  module Configuration
    # The Keybase configuration directory.
    CONFIG_DIR = if Gem.win_platform?
                   File.expand_path("#{ENV["LOCALAPPDATA"]}/Keybase").freeze
                 else
                   File.expand_path("~/.config/keybase").freeze
                 end

    # The Keybase configuration file.
    CONFIG_FILE = File.join(CONFIG_DIR, "config.json").freeze

    # there's not much this library can do without a local config
    raise KeybaseNotInstalledError unless File.file?(CONFIG_FILE)

    # The hash from Keybase's configuration file.
    CONFIG_HASH = JSON.parse(File.read(CONFIG_FILE)).freeze

    # The mountpoint for KBFS.
    KBFS_MOUNT = "/keybase"

    # @return [String] the currently logged-in user
    def current_user
      CONFIG_HASH["current_user"]
    end

    # @return [Array<Keybase::LocalUser>] a list of all local users known
    #  to Keybase
    def local_users
      CONFIG_HASH["users"].map { |_, v| Keybase::LocalUser.new(v) }
    end

    # @return [String] the user's private KBFS directory
    def private_dir
      File.join(KBFS_MOUNT, "private", current_user)
    end

    # @return [String] the user's public KBFS directory
    def public_dir
      File.join(KBFS_MOUNT, "public", current_user)
    end

    # @return [Boolean] whether or not Keybase is currently running
    def running?
      if Gem.win_platform?
        !`tasklist | find "keybase.exe"`.empty?
      else
        # is there a more efficient way to do this that doesn't involve an exec?
        Dir["/proc/[0-9]*/comm"].any? do |comm|
          File.read(comm).chomp == "keybase" rescue false # hooray for TOCTOU
        end
      end
    end

    # @return [String] the running Keybase's version string
    # @raise [KeybaseNotRunningError] if Keybase is not running
    def running_version
      raise KeybaseNotRunningError unless Keybase.running?
      `keybase --version`.split[2]
    end
  end
end

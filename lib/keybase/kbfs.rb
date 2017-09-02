# frozen_string_literal: true

module Keybase
  # Represents the Keybase filesystem.
  # @note This is just a stub for the time being.
  class KBFS
    # @raise [Exceptions::KeybaseNotRunningError] unless Keybase is running
    # @raise [Exceptions::KBFSNotRunningError] unless KBFS is running
    def initialize
      raise Exceptions::KeybaseNotRunningError unless Keybase.running?
      raise Exceptions::KBFSNotRunningError unless Dir.exist?("/keybase")
    end
  end
end

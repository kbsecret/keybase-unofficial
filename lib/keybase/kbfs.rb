# frozen_string_literal: true

module Keybase
  # Represents the Keybase filesystem.
  # @note This is just a stub for the time being.
  class KBFS
    # @raise [KeybaseNotRunningError] unless Keybase is running
    # @raise [KBFSNotRunningError] unless KBFS is running
    def initialize
      raise KeybaseNotRunningError unless Keybase.running?
      raise KBFSNotRunningError unless Dir.exist?("/keybase")
    end
  end
end

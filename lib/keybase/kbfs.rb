module Keybase
  class KBFS
    def initialize
      raise KeybaseNotRunningError unless Keybase.running?
      raise KBFSNotRunningError unless Dir.exist?("/keybase")
    end

    # there's nothing here yet.
    # i could add methods for moving files to and from the public
    # and private keybase directories, but that feels overkill.
  end
end

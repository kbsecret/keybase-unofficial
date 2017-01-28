module Keybase
  # A top-level exception for the library.
  class KeybaseError < RuntimeError
  end

  # Raised whenever Keybase is not running locally.
  class KeybaseNotRunningError < KeybaseError
    def initialize
      super "keybase needs to be running"
    end
  end

  # Raised whenever KBFS is not running locally.
  class KBFSNotRunningError < KeybaseError
    def initialize
      super "KBFS needs to be enabled and running"
    end
  end
end

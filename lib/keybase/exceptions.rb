module Keybase
  class KeybaseError < RuntimeError
  end

  class KeybaseNotRunningError < KeybaseError
    def initialize
      super "keybase needs to be running"
    end
  end

  class KBFSNotRunningError < KeybaseError
    def initialize
      super "KBFS needs to be enabled and running"
    end
  end
end

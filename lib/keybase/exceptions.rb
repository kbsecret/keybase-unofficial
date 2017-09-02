# frozen_string_literal: true

module Keybase
  # A namespace for all exceptions defined by {Keybase}.
  module Exceptions
    # A top-level exception for the library.
    class KeybaseError < RuntimeError
    end

    # Raised if a Keybase installation can't be found.
    class KeybaseNotInstalledError < KeybaseError
      def initialize
        super "keybase needs to be installed"
      end
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
end

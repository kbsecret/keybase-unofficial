# frozen_string_literal: true

module Keybase
  # A class for converting arrays of users into Keybase-style strings.
  class U
    class << self
      # @param args [Array<String>] the list of users to merge
      # @return [String] the Keybase-style user string
      # @example
      #  Keybase::U["a", "b"] # => "a,b"
      def [](*args)
        args.join(",")
      end
    end
  end
end

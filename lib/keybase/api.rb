# frozen_string_literal: true

require "faraday"
require "json"
require "ostruct"

module Keybase
  # Represents (parts of) the Keybase REST API.
  # @see https://keybase.io/docs/api/1.0
  class API
    # The base URL for the majority of API calls.
    BASE_URL = "https://keybase.io/_/api/1.0"

    class << self
      # Look up a user, users, or external identity.
      # @param query [Hash] the request parameters
      # @option query username [String] the username to look up
      # @option query usernames [Array<String>] multiple usernames to look up
      # @return [OpenStruct] a struct mapping of the JSON response
      # @example
      #  Keybase::API.lookup username: "yossarian"
      #  Keybase::API.lookup github: "woodruffw"
      # @note Any identity supported by keybase should work (e.g, `domain`,
      #  `hackernews`, `reddit`, `github`, etc.)
      # @see https://keybase.io/docs/api/1.0/call/user/lookup
      def lookup(**query)
        query[:usernames] = U[query[:usernames]]

        fetch_and_structify "/user/lookup.json", query
      end

      # Test whether the given user exists on Keybase.
      # @param user [String] the username to test
      # @return [Boolean] whether or not the user exists
      # @example
      #  Keybase::API.user? "yossarian" # => true
      #  Keybase::API.user? "idonotexist" # => false
      # @note This call only works on Keybase usernames, not external identities.
      def user?(user)
        lookup(username: user).status.code.zero?
      end

      # Search Keybase for identity components.
      # @param query [String] the string to search for
      # @return [OpenStruct] a struct mapping of the JSON response
      # @example
      #  Keybase::API.autocomplete "William Woodruff"
      # @see https://keybase.io/docs/api/1.0/call/user/autocomplete
      def autocomplete(query)
        fetch_and_structify "/user/autocomplete.json", q: query
      end

      # Discover Keybase users from external identities.
      # @param query [Hash] the request parameters
      # @option query flatten [Boolean] whether or not to remove duplicates
      # @option query usernames_only [Boolean] whether or not to reply with
      #  only names
      # @return [OpenStruct] a struct mapping of the JSON response
      # @example
      #  Keybase::API.discover github: "woodruffw", flatten: true
      # @note Any identity supported by keybase should work (e.g, `domain`,
      #  `hackernews`, `reddit`, `github`, etc.)
      # @see https://keybase.io/docs/api/1.0/call/user/discover
      def discover(**query)
        fetch_and_structify "/user/discover.json", query
      end

      # Retrieve the current site-wide Merkle root hash.
      # @param query [Hash] the request parameters
      # @option query seqno [Integer] a specific Merkle root to return, if found
      # @option query ctime [Integer] return the first root on or after the
      #  given time (UTC)
      # @return [OpenStruct] a struct mapping of the JSON response
      # @see https://keybase.io/docs/api/1.0/call/merkle/root
      def merkle_root(**query)
        fetch_and_structify "/merkle/root.json", query
      end

      # Retrieve a Merkle node corresponding to a given hash.
      # @param query [Hash] the request parameters
      # @option query hash [String] the hash of the block to look up
      # @return [OpenStruct] a struct mapping of the JSON response
      # @see https://keybase.io/docs/api/1.0/call/merkle/block
      def merkle_block(**query)
        fetch_and_structify "/merkle/block.json", query
      end

      # Make a GET request to the given endpoint with the given parameters.
      # @param endpoint [String] the keybase API endpoint
      # @param query [Hash] the request parameters
      # @return [OpenStruct] a struct mapping of the JSON response
      # @api private
      def fetch_and_structify(endpoint, query)
        response = Faraday.get "#{BASE_URL}#{endpoint}", query
        JSON.parse(response.body, object_class: OpenStruct)
      end
    end
  end
end

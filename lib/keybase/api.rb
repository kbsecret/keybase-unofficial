require "faraday"
require "json"
require "ostruct"
require "uri"

module Keybase
  class API
    BASE_URL = "https://keybase.io/_/api/1.0"

    class << self
      def lookup(*users)
        users = users.join(",")
        response = Faraday.get "#{BASE_URL}/user/lookup.json", usernames: users
        JSON.parse(response.body, object_class: OpenStruct)
      end

      def autocomplete(query)
        response = Faraday.get "#{BASE_URL}/user/autocomplete.json", q: query
        JSON.parse(response.body, object_class: OpenStruct)
      end

      def discover(**query)
        response = Faraday.get "#{BASE_URL}/user/discover.json", query
        JSON.parse(response.body, object_class: OpenStruct)
      end

      def merkle_root(**query)
        response = Faraday.get "#{BASE_URL}/merkle/root.json", query
        JSON.parse(response.body, object_class: OpenStruct)
      end

      def merkle_block(**query)
        response = Faraday.get "#{BASE_URL}/merkle/block.json", query
        JSON.parse(response.body, object_class: OpenStruct)
      end
    end
  end
end

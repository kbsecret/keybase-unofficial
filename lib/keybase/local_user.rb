# frozen_string_literal: true

module Keybase
  # Represents a user known to the local Keybase process.
  # These are (presumably) users that have been logged into locally.
  class LocalUser
    # @return [String] the device's unique identifier
    attr_reader :device

    # @return [String] the user's unique identifier
    attr_reader :id

    # @return [String] the user's Keybase username
    attr_reader :name

    # @return [String] some kind of salt
    # @note I have no idea what this field does.
    attr_reader :salt

    # @param fields [Hash] the user's configuration fields
    # @option fields device [String] the device's unique identifier
    # @option fields id [String] the user's unique identifier
    # @option fields name [String] the user's Keybase username
    # @option fields salt [String] some kind of salt
    def initialize(fields)
      @device = fields["device"]
      @id     = fields["id"]
      @name   = fields["name"]
      @salt   = fields["salt"]
    end
  end
end

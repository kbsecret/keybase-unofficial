module Keybase
  # Represents a user known to the local Keybase process.
  # These are (presumably) users that have been logged into locally.
  class User
    # @return [String] the device's unique identifier
    attr_reader :device

    # @return [String] the user's unique identifier
    attr_reader :id

    # @return [String] the user's Keybase username
    attr_reader :name

    # @return [String] some kind of salt
    # @note I have no idea what this field does.
    attr_reader :salt

    def initialize(hsh)
      @device = hsh["device"]
      @id = hsh["id"]
      @name = hsh["name"]
      @salt = hsh["salt"]
    end
  end
end

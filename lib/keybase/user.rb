module Keybase
  class User
    attr_reader :device, :id, :name, :salt

    def initialize(hsh)
      @device = hsh["device"]
      @id = hsh["id"]
      @name = hsh["name"]
      @salt = hsh["salt"]
    end
  end
end

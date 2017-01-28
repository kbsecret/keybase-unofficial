require_relative "keybase/exceptions"
require_relative "keybase/configuration"
require_relative "keybase/user"
require_relative "keybase/kbfs"
require_relative "keybase/api"

module Keybase
  VERSION = "0.0.1".freeze

  extend Configuration
end

require_relative "keybase/exceptions"
require_relative "keybase/configuration"
require_relative "keybase/user"
require_relative "keybase/kbfs"
require_relative "keybase/api"

# The primary namespace for keybase-unofficial.
module Keybase
  # keybase-unofficial's current version
  VERSION = "0.0.3".freeze

  extend Configuration
end

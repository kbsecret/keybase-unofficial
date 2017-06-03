# frozen_string_literal: true

require_relative "keybase/exceptions"
require_relative "keybase/configuration"
require_relative "keybase/u"
require_relative "keybase/local_user"
require_relative "keybase/kbfs"
require_relative "keybase/api"
require_relative "keybase/chat"

# The primary namespace for keybase-unofficial.
module Keybase
  # keybase-unofficial's current version
  VERSION = "0.0.6"

  extend Configuration
end

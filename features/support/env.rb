require 'yaml'

require_relative '../../helpers/browser_helper'
require_relative '../../helpers/env_helpers'
require_relative '../../helpers/file_helpers'
require_relative '../../helpers/wait_helpers'
require_relative '../../helpers/date_helpers'

World(BrowserHelper)
World(EnvHelpers)
World(FileHelpers)
World(WaitHelpers)
World(DateHelpers)

SECRETS = Object.new.extend(EnvHelpers).secrets.freeze
SETTINGS = Object.new.extend(EnvHelpers).setting.freeze

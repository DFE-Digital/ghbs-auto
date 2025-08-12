require 'yaml'

module EnvHelpers
  CONFIG ||= YAML.load_file('config.yml')

  def setting(*keys, default: nil)
    profile = ENV['TEST_ENV'] || 'default'
    config = CONFIG[profile] || CONFIG['default']

    result = keys.reduce(config) { |acc, key| acc[key.to_s] if acc }

    return result unless result.nil?
    return default unless default.nil?

    raise "Missing setting: #{keys.join(' -> ')}"
  end

  def secrets
    env = ENV['TEST_ENV'] || 'default'
    all_secrets = YAML.load_file('.secrets.yml')
    all_secrets[env] || all_secrets['default']
  end

  def browser_type
    setting("browser", default: "chrome")
  end

  def resolution
    width  = setting("viewport", "width", default: 1280).to_i
    height = setting("viewport", "height", default: 800).to_i
    [width, height]
  end
end

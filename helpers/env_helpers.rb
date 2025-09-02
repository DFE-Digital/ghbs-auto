# frozen_string_literal: true

module EnvHelpers
  def self.load_secrets
    env = ENV["TEST_ENV"] || "default"
    YAML.load_file(File.join(Dir.pwd, "config/.secrets.yml"))[env] ||
      YAML.load_file(File.join(Dir.pwd, "config/.secrets.yml"))["default"]
  end

  def self.load_settings
    env = ENV["TEST_ENV"] || "default"
    config = YAML.load_file(File.join(Dir.pwd, "config/config.yml"))
    config[env] || config["default"]
  end
end

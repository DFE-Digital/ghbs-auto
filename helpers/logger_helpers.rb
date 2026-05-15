# frozen_string_literal: true

require "logger"

module LoggerHelpers
  LOGGER = Logger.new($stdout)
  LOGGER.level = Logger::INFO
  LOGGER.formatter = proc do |severity, datetime, _progname, msg|
    "[#{datetime.strftime('%d/%m/%Y %H:%M:%S.%L')}] [#{severity}] #{msg}\n"
  end

  def log_info(message)
    LOGGER.info(message)
  end

  def log_warn(message)
    LOGGER.warn(message)
  end

  def log_error(message)
    LOGGER.error(message)
  end

  def log_debug(message)
    LOGGER.debug(message)
  end
end

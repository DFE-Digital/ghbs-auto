# frozen_string_literal: true

require "helpers/logger_helpers"

module BrowserHelpers
  include LoggerHelpers

  def restart_browser!(reason: nill)
    log_info("Restarting browser: #{reason}")
    quit_current_browser
    clear_capybara_sessions

    true
  end

  def browser_session_id
    Capybara.current_session.driver.instance_variable_get(:@browser)&.session_id
  rescue StandardError
    nil
  end

  def quit_current_browser
    Capybara.current_session.driver.quit
  rescue StandardError => e
    log_warn("Ignored error while quitting the browser: #{e.class}: #{e.message}")
  end

  def clear_capybara_sessions
    Capybara.reset_sessions!
  rescue StandardError => e
    log_warn("Ignored error while clearing the Capybara sessions: #{e.class}: #{e.message}")
  end
end

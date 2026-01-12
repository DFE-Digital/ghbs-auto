# frozen_string_literal: true

class ContentfulCmsLoginLandingPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1/span")
  end

  def button_environment_selector
    find(:xpath, "//button[@aria-label='Open side panel']")
  end

  def link_expand_find_a_buying_solution_envs
    find(:xpath, "//ul[@data-test-id='cf-ui-list']//span[text()='Find a Buying Solution (FABS)']")
  end

  def link_master_staging_env
    find(:xpath, "//ul[@data-test-id='cf-ui-list']//span[text()='Find a Buying Solution (FABS)']/ancestor::button/following-sibling::div//span[@title='master > staging']")
  end

  def text_current_environment_part_1
    find(:xpath, "//button[@data-test-id='cf-ui-space-nav-space-trigger']//span[text()='Find a Buying Solution (FABS)']")
  end

  def text_current_environment_part_2
    find(:xpath, "//button[@data-test-id='cf-ui-space-nav-space-trigger']//span[text()='master']")
  end
end

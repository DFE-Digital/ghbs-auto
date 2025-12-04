# frozen_string_literal: true

class CmsSingleCaseActionsComps
  include Capybara::DSL

  def text_section_heading
    find(:xpath, "//h1/label")
  end

  def link_add_a_case_note
    find(:xpath, "//a[text()='Add a case note']")
  end

  def link_change_case_owner
    find(:xpath, "//a[text()='Change case owner']")
  end

  def link_log_contact_with_school
    find(:xpath, "//a[text()='Log contact with school']")
  end

  def link_place_on_hold
    find(:xpath, "//a[text()='Place on hold']")
  end

  def link_resolve_case
    find(:xpath, "//a[text()='Resolve case']")
  end

  def link_reopen_case
    find(:xpath, "//a[text()='Reopen case']")
  end
end

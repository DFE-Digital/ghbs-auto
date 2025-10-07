# frozen_string_literal: true

And(/^we enable the selenium axe checks on each page$/) do
  shared_global_methods.set_axe_enabled(true)
end

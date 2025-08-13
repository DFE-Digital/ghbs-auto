Then('I am shown the resulting buying options') do
  expect(page).to have_link("Everything ICT")
  expect(page).to have_link("CCS purchasing platform catalogue")
  expect(page).to have_link("Microsoft Shape The Future")
end

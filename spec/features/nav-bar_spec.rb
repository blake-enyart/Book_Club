require 'pry'
require 'rails_helper'

RSpec.describe 'when visitor visits home page they see a navigation bar' do

  # before :each do
  #
  #
  # end

  it 'can see link to return to homepage' do
    visit '/'
    within ".topnav" do
      click_button("welcome")

      expect(page).to has_xpath?('./app/views/layouts/application.html.erb')
    end
  end


end

# User Story 2
# Visitor Navigation
#
# As a visitor
# I see a navigation bar
# This navigation bar includes links for the following:
# - a link to return to the welcome / home page of the application ("/")
# - a link to browse all books ("/books")

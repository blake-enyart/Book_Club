require 'pry'
require 'rails_helper'

RSpec.describe 'when visitor visits home page they see a navigation bar' do


  it 'can see link to return to homepage' do
    visit '/books'
    within ".topnav" do
      # save_and_open_page
      click_on("Home")
      expect(current_path).to eq('/')
    end
  end

  it 'can see link to go to books page' do
    visit '/'
    within ".topnav" do
      click_on("Books")
      expect(current_path).to eq('/books')
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

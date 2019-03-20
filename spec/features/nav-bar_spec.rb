require 'pry'
require 'rails_helper'

RSpec.describe 'when visitor visits home page they see a navigation bar' do


  it 'can see link to return to homepage' do
    visit '/books'
    within ".topnav" do
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

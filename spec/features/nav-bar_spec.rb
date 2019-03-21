require 'rails_helper'

RSpec.describe 'user sees links on every page' do
  describe 'user visits /' do
    it 'can see navigation links' do

      visit root_path

      within ".top-nav" do
        click_link("Home")
        expect(current_path).to eq(root_path)
      end

      within ".top-nav" do
        click_link("Books")
        expect(current_path).to eq(books_path)
      end
    end
  end
end

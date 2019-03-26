require 'rails_helper'

RSpec.describe "user sees book show page", type: :feature do
  describe 'user visits /book/:id' do
    it 'user adds new review' do
      book_1 = Book.create!(title: "Title_1", number_of_pages: 100, year_published: 1, book_cover_url: "book_cover_1")

      visit book_path(book_1)

      expect(current_path).to eq(book_path(book_1))

      click_link('Add Review')

      expect(current_path).to eq(new_book_review_path(book_1))

      fill_in 'review[title]', with: 'title_1'
      fill_in 'review[rating]', with: 1
      fill_in 'review[text]', with: 'review_body_1'
      fill_in 'review[username]', with: 'user_1'

      click_button 'Create Review'

      expect(current_path).to eq(book_path(book_1))
      expect(page).to have_content('Title: title_1')
      expect(page).to have_content('Rating: 1')
      expect(page).to have_content('Description: review_body_1')
      expect(page).to have_content('User Name: user_1')
    end
  end
end

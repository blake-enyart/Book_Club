require 'rails_helper'

RSpec.describe "user sees all books", type: :feature do
  describe 'user visits /books' do
    it 'user adds new book' do
      book_name = 'Sphere'

      visit new_book_path

      fill_in 'book[title]', with: 'Sphere'
      fill_in 'book[year_published]', with: 1988
      fill_in 'book[number_of_pages]', with: 345
      fill_in 'book[book_cover_url]', with: 'https://upload.wikimedia.org/wikipedia/en/b/b8/Big-sphere.jpg'
      fill_in 'authors', with: "Michael Crichton"

      click_button 'Create Book'

      book = Book.last
      expect(current_path).to eq(book_path(book))
      expect(new_book.book).to eq(book)
      expect(new_book.title).to eq('Sphere')
    end
  end
end


# As a Visitor,
# When I visit the book index page,
# I see a link that allows me to add a new book.
# When I click that link, I am taken to a new book path.
# I can fill in a form to add a new book.
# The form includes the following items:
# - title
# - year book was published
# - number of pages (0 or higher)
# - image of the book cover (optional, can be left blank)
# - a list of authors (see notes below)
#
# When I submit the form, I am taken to that book's show page.
#
# Book titles should be converted to Title Case before saving.
# Book titles should be unique within the system.
# For authors, a comma-separated list of names should be entered,
# and each author will be added to the database.
# Authors added to the database should have their names converted
# to Title Case.
# Author Names should be unique within the system.
# If image field is left blank, a default image should be set.

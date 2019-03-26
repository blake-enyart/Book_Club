require 'rails_helper'

RSpec.describe "user sees all books", type: :feature do
  describe 'user visits /books' do
    it 'user adds new book and cant create new book with same title' do

      visit root_path
      within 'top-nav'
      click_link 'New Book'


      fill_in 'book[title]', with: 'Sphere'
      fill_in 'book[year_published]', with: 1988
      fill_in 'book[number_of_pages]', with: 345
      fill_in 'book[book_cover_url]', with: 'https://upload.wikimedia.org/wikipedia/en/b/b8/Big-sphere.jpg'
      #add test to add multiple authors
      fill_in 'authors', with: 'Michael Crichton'

      click_button 'Create Book'

      new_book = Book.last


      expect(current_path).to eq(book_path(new_book))
      expect(new_book.title).to eq('Sphere')
      expect(new_book.year_published).to eq(1988)
      expect(new_book.book_cover_url).to eq('https://upload.wikimedia.org/wikipedia/en/b/b8/Big-sphere.jpg')
      expect(new_book.authors[0].name).to eq('Michael Crichton')


      visit root_path
      within 'top-nav'
      click_link 'New Book'

      fill_in 'book[title]', with: 'Sphere'
      fill_in 'book[year_published]', with: 1983
      fill_in 'book[number_of_pages]', with: 3425
      fill_in 'book[book_cover_url]', with: 'https://upload.wikimedia.org/wikipedia/en/b/b8/Big-sphere.jpg'
      fill_in 'authors', with: 'Michael Crichton'

      click_button 'Create Book'

      new_book = Book.last

      expect(current_path).to_not eq(book_path(new_book))
    end


    it 'user adds new book and the authors name it titleized' do

      visit root_path
      within 'top-nav'
      click_link 'New Book'


      fill_in 'book[title]', with: 'Sphere'
      fill_in 'book[year_published]', with: 1988
      fill_in 'book[number_of_pages]', with: 345
      fill_in 'book[book_cover_url]', with: 'https://upload.wikimedia.org/wikipedia/en/b/b8/Big-sphere.jpg'
      fill_in 'authors', with: 'michael crichton'

      click_button 'Create Book'

      new_book = Book.last

      expect(current_path).to eq(book_path(new_book))
      expect(new_book.title).to eq('Sphere')
      expect(new_book.year_published).to eq(1988)
      expect(new_book.book_cover_url).to eq('https://upload.wikimedia.org/wikipedia/en/b/b8/Big-sphere.jpg')
      expect(new_book.authors[0].name).to eq('Michael Crichton')
    end
    it 'user adds new book and it can include multiple authors' do

      visit root_path
      within 'top-nav'
      click_link 'New Book'


      fill_in 'book[title]', with: 'Sphere'
      fill_in 'book[year_published]', with: 1988
      fill_in 'book[number_of_pages]', with: 345
      fill_in 'book[book_cover_url]', with: 'https://upload.wikimedia.org/wikipedia/en/b/b8/Big-sphere.jpg'
      #add test to add multiple authors
      fill_in 'authors', with: 'michael crichton, Jeremiah Tungsten'

      click_button 'Create Book'

      new_book = Book.last

      expect(current_path).to eq(book_path(new_book))
      expect(new_book.title).to eq('Sphere')
      expect(new_book.year_published).to eq(1988)
      expect(new_book.book_cover_url).to eq('https://upload.wikimedia.org/wikipedia/en/b/b8/Big-sphere.jpg')
      expect(new_book.authors[0].name).to eq('Michael Crichton')
      expect(new_book.authors[1].name).to eq('Jeremiah Tungsten')
    end

    it 'user adds new book and and has no image' do

      visit root_path
      within 'top-nav'
      click_link 'New Book'


      fill_in 'book[title]', with: 'Sphere'
      fill_in 'book[year_published]', with: 1988
      fill_in 'book[number_of_pages]', with: 345
      fill_in 'authors', with: 'michael crichton'

      click_button 'Create Book'

      new_book = Book.last

      expect(current_path).to eq(book_path(new_book))
      expect(new_book.title).to eq('Sphere')
      expect(new_book.year_published).to eq(1988)
      expect(new_book.book_cover_url).to eq('https://islandpress.org/sites/default/files/400px%20x%20600px-r01BookNotPictured.jpg')
      expect(new_book.authors[0].name).to eq('Michael Crichton')
    end

    it 'user adds new book and and has no image' do

      visit root_path
      within 'top-nav'
      click_link 'New Book'


      fill_in 'book[title]', with: 'Sphere'
      fill_in 'book[year_published]', with: 1988
      fill_in 'book[number_of_pages]', with: 345
      fill_in 'authors', with: 'michael crichton'

      click_button 'Create Book'

      new_book = Book.last

      expect(current_path).to eq(book_path(new_book))
      expect(new_book.title).to eq('Sphere')
      expect(new_book.year_published).to eq(1988)
      expect(new_book.book_cover_url).to eq('https://islandpress.org/sites/default/files/400px%20x%20600px-r01BookNotPictured.jpg')
      expect(new_book.authors[0].name).to eq('Michael Crichton')
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

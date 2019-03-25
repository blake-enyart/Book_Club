require 'rails_helper'

RSpec.describe 'Delete author workflow' do
  context 'as a visitor' do
    it 'deletes author correctly' do
      @book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      @author_1 = @book_1.authors.create(name: "Delia Owens")

      visit author_path(@author_1)
      within 'body'

      click_on 'delete_author'

      expect(page).to_not have_link(@book_1.title)
      expect(page).to_not have_content("Number of Pages: #{@book_1.number_of_pages}")
      expect(page).to_not have_content("Year Published: #{@book_1.year_published}")
      expect(page).to_not have_xpath("//img[@src='#{@book_1.book_cover_url}']")
      expect(current_path).to eq(books_path)
    end
  end
end

# As a Visitor,
# When I visit an author's show page,
# I see a link on the page to delete the author.
# This link should return me to the book index page where I
# no longer see this author listed.
# If this author was the only author for any book, that book is also deleted.
# If this author co-authored a book with someone else, that book should also be deleted, but not the other author.
#
# (you may need to delete other content before you can delete an author or book)

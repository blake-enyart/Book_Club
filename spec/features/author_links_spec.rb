require 'rails_helper'

RSpec.describe 'author links' do
  context 'as a visitor' do
    describe 'links lead to author show page' do

      before :each do
        @book_1 = Book.create!(title: "Wheadas", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
        @author_1 = @book_1.authors.create(name: "Dia Owens")
      end

      it 'can click on an author name anywhere and link to the show page' do

        visit books_path

        within '.book-ctn' do
          click_link "Dia Owens"

          expect(current_path).to eq(author_path(@author_1))
        end
      end
    end
  end
end

# As a visitor
# With the exception of an author's show page,
# Anywhere I see an author's name on the site,
# I can click on the name to go to that author's show page.

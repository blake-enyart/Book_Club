RSpec.describe 'Author Names Link' do
  context 'as a visitor' do
    describe 'Author links lead to author show page' do

      before :each do
        @book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
        @book_2 = Book.create(title: "East of Eden", number_of_pages: 608, year_published: 1952, book_cover_url: "https://upload.wikimedia.org/wikipedia/en/5/56/EastOfEden.jpg")

        @author_1 = @book_1.authors.create(name: "Delia Owens")
        @author_2 = @book_2.authors.create(name: "John Steinbeck")

        @review_11 = @book_4.reviews.create(title: 'title_11', rating: 1, text: 'body_11', username: 'user_4')
      end

      it 'can click on an author name anywhere and link to the show page' do
      visit book_path

      click_link 'author.name'

      expect(current_path).to eq(author_path(@author_1))
    end
  end
end

# As a visitor
# With the exception of an author's show page,
# Anywhere I see an author's name on the site,
# I can click on the name to go to that author's show page.

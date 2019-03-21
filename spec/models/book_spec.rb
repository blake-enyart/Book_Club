require 'rails_helper'

describe Book, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :number_of_pages }
    it { should validate_presence_of :year_published }
    it { should validate_presence_of :book_cover_url }
  end

  describe 'relationships' do
    it { should have_many :reviews }
    it { should have_many :authors_books }
    it { should have_many(:authors).through(:authors_books) }
  end

  describe 'class-methods' do
    before :each do
      @book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      @book_2 = Book.create(title: "East of Eden", number_of_pages: 608, year_published: 1952, book_cover_url: "https://upload.wikimedia.org/wikipedia/en/5/56/EastOfEden.jpg")

      @author_1 = @book_1.authors.create(name: "Delia Owens")
      @author_2 = @book_2.authors.create(name: "John Steinbeck")
      @author_2 = @book_2.authors.create(name: "Other Guy")

      @review_1 = @book_1.reviews.create(title: 'title_1', rating: 2, text: 'body_1', username: 'user_1')
      @review_2 = @book_1.reviews.create(title: 'title_2', rating: 4, text: 'body_2', username: 'user_1')
      @review_3 = @book_1.reviews.create(title: 'title_3', rating: 2, text: 'body_3', username: 'user_2')
      @review_4 = @book_1.reviews.create(title: 'title_4', rating: 4, text: 'body_4', username: 'user_2')

      @review_5 = @book_2.reviews.create(title: 'title_5', rating: 1, text: 'body_5', username: 'user_1')
      @review_6 = @book_2.reviews.create(title: 'title_6', rating: 3, text: 'body_6', username: 'user_1')
      @review_7 = @book_2.reviews.create(title: 'title_7', rating: 1, text: 'body_7', username: 'user_2')
      @review_8 = @book_2.reviews.create(title: 'title_8', rating: 3, text: 'body_8', username: 'user_2')
    end

    it '.average_review' do
      expected = 3
      actual = @book_1.average_review

      expect(actual).to eq(expected)

      expected = 2
      actual = @book_2.average_review

      expect(actual).to eq(expected)
    end
  end
end

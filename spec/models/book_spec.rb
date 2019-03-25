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
      @book_3 = Book.create(title: "Book_3", number_of_pages: 300, year_published: 3, book_cover_url: "image_3")
      @book_4 = Book.create(title: "Book_4", number_of_pages: 400, year_published: 4, book_cover_url: "image_4")

      @author_1 = @book_1.authors.create(name: "Delia Owens")
      @author_2 = @book_2.authors.create(name: "John Steinbeck")
      @author_2 = @book_2.authors.create(name: "Other Guy")
      @book_3.authors = [@author_1]
      @book_4.authors = [@author_1, @author_2]

      @review_1 = @book_1.reviews.create(title: 'title_1', rating: 5, text: 'body_1', username: 'user_1')
      @review_2 = @book_1.reviews.create(title: 'title_2', rating: 5, text: 'body_2', username: 'user_1')
      @review_3 = @book_1.reviews.create(title: 'title_3', rating: 3, text: 'body_3', username: 'user_2')
      @review_4 = @book_1.reviews.create(title: 'title_4', rating: 3, text: 'body_4', username: 'user_2')

      @review_5 = @book_2.reviews.create(title: 'title_5', rating: 5, text: 'body_5', username: 'user_1')
      @review_6 = @book_2.reviews.create(title: 'title_6', rating: 4, text: 'body_6', username: 'user_1')
      @review_7 = @book_2.reviews.create(title: 'title_7', rating: 3, text: 'body_7', username: 'user_2')
      @review_8 = @book_2.reviews.create(title: 'title_8', rating: 3, text: 'body_8', username: 'user_2')

      @book_3.reviews.create(title: 'title_8', rating: 5, text: 'body_8', username: 'user_3')

      @book_4.reviews.create(title: 'title_8', rating: 1, text: 'body_8', username: 'user_4')
      @book_4.reviews.create(title: 'title_8', rating: 1, text: 'body_8', username: 'user_4')

    end

    it '.average_review' do
      expected = 4
      actual = @book_1.average_review

      expect(actual).to eq(expected)

      expected = 3.75
      actual = @book_2.average_review

      expect(actual).to eq(expected)
    end

    it '.top_books' do
      actual = Book.top_books(1)
      expected = [@book_3]

      expect(actual.length).to eq(1)
      expect(actual).to eq(expected)

      actual = Book.top_books(3)
      expected = [@book_3, @book_1, @book_2]

      expect(actual.length).to eq(3)
      expect(actual).to eq(expected)
    end

    it '.bottom_books' do
      expected = Book.bottom_books(1)

      expect(expected.length).to eq(1)
      expect(expected).to eq([@book_4])

      expected = Book.bottom_books(3)

      expect(expected.length).to eq(3)
      expect(expected).to eq([@book_4, @book_2, @book_1])
    end

    it '.sort_by' do
      #highest average review test
      actual = Book.sort_by(['AVG(reviews.rating)', 'DESC'])
      expected = [@book_3, @book_1, @book_2, @book_4]

      expect(actual).to eq(expected)

      #lowest averate review test
      actual = Book.sort_by(['AVG(reviews.rating)', 'ASC'])
      expected = [@book_3, @book_1, @book_2, @book_4].reverse

      expect(actual).to eq(expected)

      #highest number of pages test
      actual = Book.sort_by(['books.number_of_pages', 'DESC'])
      expected = [@book_2, @book_4, @book_1, @book_3]

      expect(actual).to eq(expected)

      #lowest number of pages test
      actual = Book.sort_by(['books.number_of_pages', 'ASC'])
      expected = [@book_2, @book_4, @book_1, @book_3].reverse

      expect(actual).to eq(expected)

      #highest number of reviews test
      actual = Book.sort_by(['COUNT(reviews.id)', 'DESC'])
      expected = [@book_2, @book_1, @book_4, @book_3]

      expect(actual).to eq(expected)

      #lowest number of reviews test
      actual = Book.sort_by(['COUNT(reviews.id)', 'ASC'])
      expected = [@book_3, @book_4, @book_2, @book_1]

      expect(actual).to eq(expected)
    end
  end

  describe 'top_3_statistics' do
    before :each do
      @book_1 = Book.create(title: "Where the Crawdads Sing", number_of_pages: 384, year_published: 2018, book_cover_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")

      @review_1 = @book_1.reviews.create(title: 'title_1', rating: 2, text: 'body_1', username: 'user_1')
      @review_2 = @book_1.reviews.create(title: 'title_2', rating: 5, text: 'body_2', username: 'user_1')
      @review_3 = @book_1.reviews.create(title: 'title_3', rating: 4, text: 'body_3', username: 'user_2')
      @review_4 = @book_1.reviews.create(title: 'title_4', rating: 5, text: 'body_4', username: 'user_2')
      @review_5 = @book_1.reviews.create(title: 'title_1', rating: 2, text: 'body_1', username: 'user_1')
      @review_6 = @book_1.reviews.create(title: 'title_2', rating: 5, text: 'body_2', username: 'user_1')
      @review_7 = @book_1.reviews.create(title: 'title_3', rating: 4, text: 'body_3', username: 'user_2')
      @review_7 = @book_1.reviews.create(title: 'title_4', rating: 2, text: 'body_4', username: 'user_2')
    end

    it '.top_three_reviews' do
      expected = [@review_2, @review_6, @review_4]
      actual = @book_1.top_three_reviews

      expect(actual).to eq(expected)
    end

    it '.bottom_three_reviews' do
      expected = [@review_1, @review_5, @review_7]
      actual = @book_1.bottom_three_reviews

      expect(actual).to eq(expected)
    end
  end
end

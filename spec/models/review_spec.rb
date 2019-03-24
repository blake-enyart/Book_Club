require 'rails_helper'

describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :text }
    it { should validate_presence_of :username }
  end

  describe 'relationships' do
    it { should belong_to :book }
  end

  describe 'Class Methods' do
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

      @review_9 = @book_3.reviews.create(title: 'title_9', rating: 5, text: 'body_9', username: 'user_3')

      @review_10 = @book_4.reviews.create(title: 'title_10', rating: 1, text: 'body_10', username: 'user_4')
      @review_11 = @book_4.reviews.create(title: 'title_11', rating: 1, text: 'body_11', username: 'user_4')
    end

    it '.top_reviewers' do
      actual = Review.top_reviewers(1)
      expected = [['user_1', 4]]

      expect(actual).to eq(expected)

      actual = Review.top_reviewers(3)
      expected = [['user_1', 4],['user_2', 4],['user_4', 2]]

      expect(actual).to eq(expected)
    end
  end
end

class Book < ApplicationRecord

  has_many :reviews, :dependent => :destroy
  has_many :authors_books, :dependent => :destroy
  has_many :authors, through: :authors_books

  validates_presence_of :title, :number_of_pages, :year_published, :book_cover_url
  validates_uniqueness_of :title

  def average_review
    self.reviews.average(:rating)
  end

  def top_review
    self.reviews.order(:rating).reverse.first(1)
  end

  def top_three_reviews
    self.reviews.order(:rating).reverse.first(3)
  end

  def bottom_three_reviews
    self.reviews.order(:rating).first(3)
  end

  def self.top_books(limit)
    Book.joins(:reviews)
        .select('books.*, AVG(reviews.rating) AS avg_score')
        .group(:id)
        .order('avg_score DESC, books.title ASC')
        .limit(limit)
  end

  def self.bottom_books(limit)
    Book.joins(:reviews)
        .select('books.*, AVG(reviews.rating) AS avg_score')
        .group(:id)
        .order('avg_score ASC, books.title ASC')
        .limit(limit)
  end

  def self.sort_by(sort_method)
    self.joins(:reviews)
        .select("books.*, #{sort_method[0]} AS sort_attr")
        .group(:id)
        .order("sort_attr #{sort_method[1]}, books.title ASC")
  end
end

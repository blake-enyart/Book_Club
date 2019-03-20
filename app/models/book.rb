class Book < ApplicationRecord

  has_many :reviews 
  has_many :authors_books
  has_many :authors, through: :authors_books

  validates_presence_of :title, :number_of_pages, :year_published, :book_cover_url
end

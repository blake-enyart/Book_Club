class Book < ApplicationRecord
  has_many :reviews
  
  validates_presence_of :title, :number_of_pages, :year_published, :book_cover_url
end

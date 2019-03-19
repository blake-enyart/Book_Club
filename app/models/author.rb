class Author < ApplicationRecord
  has_many :books, through: :author_books
  
  validates_presence_of :name
end

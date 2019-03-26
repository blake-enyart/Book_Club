class Author < ApplicationRecord
  has_many :authors_books, :dependent => :destroy
  has_many :books, through: :authors_books

  validates_presence_of :name
end

class Review < ApplicationRecord
  belongs_to :book
  
  validates_presence_of :title, :rating, :text
end

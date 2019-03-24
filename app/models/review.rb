class Review < ApplicationRecord
  belongs_to :book

  validates_presence_of :title, :rating, :text, :username

  def self.top_reviewers(limit)
    review_count = Review.group(:username).count.sort_by{ |k,v| v }.reverse
    review_count.slice(0,limit)
    # review_count = Review.select('reviews.*, COUNT(reviews.username) AS review_count').group(:id).first(4)
    # binding.pry
  end
end

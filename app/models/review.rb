class Review < ApplicationRecord
  belongs_to :book


  validates_presence_of :title, :rating, :text, :username

  def self.top_reviewers(limit)
    # review_count = Review.group(:username).count.sort_by{ |k,v| v }.reverse
    # review_count.slice(0,limit)
    review_count = Review.select('reviews.username, COUNT(reviews.username) AS review_count')
                         .group(:username)
                         .order('review_count DESC, reviews.username ASC')
                         .first(limit)

    review_count_array = []

    review_count.each do |query|
      review_count_array << [query.username, query.review_count]
    end
    review_count_array
  end
end

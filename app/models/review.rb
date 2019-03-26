class Review < ApplicationRecord
  belongs_to :book

  validates_presence_of :title, :rating, :text, :username

  before_save do |review|
    review.username = review.username.downcase.titleize
  end

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

  def self.find_reviews(user_name)
    review_list = where(username: user_name).order(:created_at)
    if review_list[0]
      review_list
    else
      user_name
    end
  end

  def self.sort_reviews(user_name, sort_method)
    if sort_method == 'newest'
      where(username: user_name).order(created_at: :desc)
    elsif sort_method == 'oldest'
      where(username: user_name).order(created_at: :asc)
    end
  end

  def self.add_review(book, review_params)
    book_review_users = book.reviews.pluck(:username)
    if book_review_users.include?(review_params[:username].titlecase)
      false
    else
      book.reviews.create(review_params)
      true
    end
  end
end

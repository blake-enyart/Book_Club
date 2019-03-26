class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    if review_params[:rating].to_i < 5 && review_params[:rating].to_i > 0
      book = Book.find(params[:book_id])
      review = Review.add_review(book, review_params)
      redirect_to book_path(book)
    else
      redirect_to new_book_review_path(params[:book_id])
    end
  end

  def show
    @user_reviews = Review.find_reviews(params[:username])
    if params[:sort] == 'newest'
      @user_reviews = Review.sort_reviews(params[:username], params[:sort])
    end
  end

  def destroy
    username = Review.find(params[:id]).username
    review = Review.find(params[:id])
    review.destroy
    redirect_to user_path(username)
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :text, :username)
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require './app/models/book'

Review.destroy_all
Book.destroy_all
Author.destroy_all

file_path = './db/data/authors.csv'
file = File.open(file_path)
author_list = CSV.new(file, headers: true, header_converters: :symbol).read

author_list = author_list.map { |author| author.to_h }
#
# author_list.each do |author|
#   Authors.find_or_create_by(name: author[:name])
# end

file_path = './db/data/books.csv'
file = File.open(file_path)
books_list = CSV.new(file, headers: true, header_converters: :symbol).read

books_list = books_list.map { |book| book.to_h }

books_list.each do |book|
  new_book = Book.create(book)
  author_list.each do |author|
    if author[:book_title].titlecase == new_book.title
      new_book.authors << Author.find_or_create_by(name: author[:name])
    end
  end
end

file_path = './db/data/reviews.csv'
file = File.open(file_path)
review_list = CSV.new(file, headers: true, header_converters: :symbol).read

review_list = review_list.map { |review| review.to_h }

review_list.each do |review|
  Book.find_by(title: review[:book_title].titlecase).reviews.create(title: review[:title],
                                                           username: review[:user_name],
                                                           rating: review[:rating],
                                                           text: review[:text])
end

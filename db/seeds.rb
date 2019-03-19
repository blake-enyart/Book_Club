# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require './app/models/book'

Book.destroy_all

file_path = './db/data/books.csv'
file = File.open(file_path)
books_list = CSV.new(file, headers: true, header_converters: :symbol).read

books_list = books_list.map { |book| book.to_h }

books_list.each do |book|
  Book.create(book)
end

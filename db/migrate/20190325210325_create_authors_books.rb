class CreateAuthorsBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :authors_books do |t|
      t.references :author, foreign_key: true
      t.references :book, foreign_key: true
    end
  end
end

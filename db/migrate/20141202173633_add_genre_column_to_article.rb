class AddGenreColumnToArticle < ActiveRecord::Migration
  def change
  	add_column :articles, :genre, :string
  end
end

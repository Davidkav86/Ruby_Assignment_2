class ChangeArticleColumn < ActiveRecord::Migration
  def change
  	rename_column :comments, :atricle_id, :article_id
  end
  add_index :comments, [:article_id, :created_at]
end

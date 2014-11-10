class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true # tells the db that email should be unique and used as an index
  end
end

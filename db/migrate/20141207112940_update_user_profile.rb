class UpdateUserProfile < ActiveRecord::Migration
  def change
  	add_column :users, :picture, :string
  	add_column :users, :personal_message, :text
  	add_column :users, :fav_sport, :string
  	add_column :users, :fav_team_athlete, :string
  end
end

class Article < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
end

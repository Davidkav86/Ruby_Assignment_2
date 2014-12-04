class Article < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 200 }
  validates :content, presence: true
  validates :genre, presence: true

  has_many :comments, dependent: :destroy

  def self.search(search)
     where("genre like ?", "%#{search}%")
  end
end

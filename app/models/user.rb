class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics
  has_many :bookmarks
  has_many :likes, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def liked(bookmark)
    likes.where(bookmark_id: bookmark.id).first
  end
end

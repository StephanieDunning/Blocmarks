class Bookmark < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  validates :topic, presence: true
  validates :url, presence: true
end

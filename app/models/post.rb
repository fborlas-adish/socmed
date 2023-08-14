class Post < ApplicationRecord
  has_many_attached :media
  belongs_to :user

  validates :body, presence: true, length: { minimum: 1 }
end

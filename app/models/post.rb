class Post < ApplicationRecord
  resourcify

  has_many_attached :media
  belongs_to :user

  validates :body, presence: true, length: { minimum: 1 }

  def can_update?(updater)
    user == updater
  end
end

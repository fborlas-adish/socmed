class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"

  VALID_STATUSES = ['pending', 'accepted', 'declined']

  validates :friendship_status, inclusion: { in: VALID_STATUSES }
end

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable

  has_many :posts, dependent: :destroy
  has_many :friendships, foreign_key: :user_id, class_name: "Friendship"
  has_many :friends, through: :friendships, source: :friend

  has_one_attached :avatar

  def full_name
    first_name + " " + last_name
  end
end

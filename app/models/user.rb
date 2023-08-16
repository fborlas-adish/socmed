class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable

  has_many :posts, dependent: :destroy

  has_one_attached :avatar
  
  def full_name
    first_name + " " + last_name
  end
end

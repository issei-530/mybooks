class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_books
  has_many :books, through: :user_books, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def my_list
    books
  end
  
  validates :nickname,presence: true, length: { maximum: 6 }
end

class Book < ApplicationRecord
  has_many :user_books
  has_many :users, through: :user_books
  has_many :reviews, dependent: :destroy

  def self.search(query)
    if query.present?
      where("title LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end

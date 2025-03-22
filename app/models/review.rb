class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true

  def self.search(query)
    if query.present?
      where("content LIKE ?", "%#{query}%")
    else
      all
    end
  end
end

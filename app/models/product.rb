class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true, length: { minimum: 8, maximum: 100 }
  validates :description, length: { minimum: 20, maximum: 1000 }
  validates :price, numericality: { 
    greater_than_or_equal_to: 0.01,
    message: 'must be greater than 0.00'
  }
  validates :image_url, allow_blank: true, format: {
    with: /\.(jpg|jpeg|gif|png)\Z/i,
    message: 'expected URL for file with an image extension'
  }
end

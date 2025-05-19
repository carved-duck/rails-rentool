class Tool < ApplicationRecord
  belongs_to :user
  has_many :rentals

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :condition, presence: true
  validates :rental_price, presence: true
  validates :category, presence: true

end

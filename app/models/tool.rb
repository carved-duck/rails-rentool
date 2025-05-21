class Tool < ApplicationRecord
  belongs_to :user
  has_many :rentals, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
  validates :description, presence: true
  validates :condition, presence: true
  validates :price, presence: true
  validates :category, presence: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end

class Rental < ApplicationRecord
  belongs_to :tool
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :rental_status, presence: true
  validates :total_price, presence: true
end

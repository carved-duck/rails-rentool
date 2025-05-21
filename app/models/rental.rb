class Rental < ApplicationRecord
  belongs_to :tool
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validates :total_price, presence: true

  def num_of_days
    (end_date - start_date).to_i
  end
end

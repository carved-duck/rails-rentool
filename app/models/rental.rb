class Rental < ApplicationRecord
  belongs_to :tool
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validates :total_price, presence: true

  def num_of_days
    if end_date && start_date
      return (end_date - start_date).to_i
    else
      return 1
    end
  end

  def pending?
    status == 'pending'
  end
end

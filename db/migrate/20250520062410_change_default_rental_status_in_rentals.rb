class ChangeDefaultRentalStatusInRentals < ActiveRecord::Migration[7.1]
  def change
    remove_column :rentals, :rental_status, :string
     add_column :rentals, :status, :string, default: "pending"
    add_column :tools, :price, :integer
    remove_column :tools, :rental_price, :integer
  end

end

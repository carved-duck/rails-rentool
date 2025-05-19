class CreateTools < ActiveRecord::Migration[7.1]
  def change
    create_table :tools do |t|
      t.string :name
      t.string :description
      t.string :condition
      t.string :location
      t.integer :rental_price
      t.string :category
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spaces do |t|
      t.string :title
      t.string :description
      t.string :facilities
      t.references :user, null: false, foreign_key: true

      # Additional fields
      t.string :equipment
      t.integer :capacity
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :city
      t.decimal :price
      t.text :available_dates, array: true, default: []

      t.timestamps
    end
  end
end

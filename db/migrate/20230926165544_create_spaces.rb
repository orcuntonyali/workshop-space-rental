class CreateSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spaces do |t|
      t.string :title
      t.string :description
      t.string :facilities
      t.string :equipment
      t.integer :capacity
      t.boolean :availability
      t.references :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end

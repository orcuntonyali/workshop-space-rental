class AddPriceToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :price, :decimal
  end
end

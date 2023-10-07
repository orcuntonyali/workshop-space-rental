class AddSelectDateToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :select_date, :datetime
  end
end

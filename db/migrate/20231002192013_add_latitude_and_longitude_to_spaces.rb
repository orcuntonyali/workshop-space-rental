class AddLatitudeAndLongitudeToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :latitude, :float
    add_column :spaces, :longitude, :float
  end
end

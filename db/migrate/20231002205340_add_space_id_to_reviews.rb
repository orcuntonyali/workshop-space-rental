class AddSpaceIdToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :space, null: false, foreign_key: true
  end
end

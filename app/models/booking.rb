class Booking < ApplicationRecord
  belongs_to :space_id
  belongs_to :user_id
end

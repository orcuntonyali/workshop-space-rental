class Review < ApplicationRecord
  belongs_to :user
  belongs_to :space
  belongs_to :booking

  validates :user_id, uniqueness: { scope: :space_id, message: "You can only write one review per space" }
  validate :user_must_be_booker

  private

  def user_must_be_booker
    errors.add(:user_id, "must be a booker to leave a review") unless user&.booker?
  end
end

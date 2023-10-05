class Space < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :bookings, dependent: :destroy

  validate :user_must_be_lister

  include PgSearch::Model
  multisearchable against: [:city, :title]

  private

  def user_must_be_lister
    errors.add(:user_id, "must be a lister to create a space") unless user&.lister?
  end
end

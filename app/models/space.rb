class Space < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  has_many :reviews
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validate :user_must_be_lister

  pg_search_scope :search_by_city_and_title, against: %i[city title],
                                             using: { tsearch: { prefix: true } }

  def available?(date)
    available_dates.include?(date.to_s) && bookings.where(booking_date: date).none?
  end

  private

  def user_must_be_lister
    errors.add(:user_id, "must be a lister to create a space") unless user&.lister?
  end
end

class User < ApplicationRecord
  enum role: { booker: 0, lister: 1 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :spaces
  has_many :bookings
end

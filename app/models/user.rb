class User < ApplicationRecord
  enum role: { booker: 0, lister: 1 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :spaces, dependent: :destroy
  has_many :bookings
end

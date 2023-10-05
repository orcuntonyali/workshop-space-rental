class User < ApplicationRecord
  enum role: { booker: 0, lister: 1 }
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :spaces, dependent: :destroy
  has_many :bookings
  has_many :reviews

  def lister?
    role == "lister"
  end

  def booker?
    role == "booker"
  end

  validates :username, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end

# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

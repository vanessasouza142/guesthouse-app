class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: {guest: 0, host: 10}
  has_one :guesthouse
  has_many :bookings
  has_many :rooms, through: :bookings
  has_many :reviews, through: :bookings

  validates :name, :role, presence: true

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # enum role: { guest: 0, host: 10 }
  enum role: {guest: 0, host: 10}
  has_one :guesthouse

  validates :name, :role, presence: true
  # validates_uniqueness_of :role
end

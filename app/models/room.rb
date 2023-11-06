class Room < ApplicationRecord
  enum status: {unavailable: 0, available: 2}
  belongs_to :guesthouse
  has_many :custom_prices

  validates :name, :description, :area, :max_guest, :default_price, presence: true
end

class Room < ApplicationRecord
  belongs_to :guesthouse
  has_many :custom_prices

  validates :name, :description, :area, :max_guest, :default_price, presence: true
end

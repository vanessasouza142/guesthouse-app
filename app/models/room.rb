class Room < ApplicationRecord
  belongs_to :guesthouse

  validates :name, :description, :area, :max_guest, :daily_price, presence: true
end

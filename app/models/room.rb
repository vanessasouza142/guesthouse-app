class Room < ApplicationRecord
  belongs_to :guesthouse

  validates :name, :description, :area, :max_guest, :daily_price, :bathroom, :balcony, :air_conditioner, :tv, :wardrobe, :safe, 
            :accessible, presence: true
end

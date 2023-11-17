class Room < ApplicationRecord
  belongs_to :guesthouse
  has_many :custom_prices
  has_many :bookings
  has_many :users, through: :bookings
  enum status: {unavailable: 0, available: 2}

  validates :name, :description, :area, :max_guest, :default_price, presence: true

  def current_daily_price(date)
    default_price = self.default_price
    custom_prices = self.custom_prices
      
    custom_prices.each do |cp|
      if date >= cp.begin_date && date < cp.end_date
        return cp.price
      end
    end  
    default_price
  end

end

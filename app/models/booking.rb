class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  enum status: {pending: 0, in_progress: 2, canceled: 5}
  
  validates :check_in_date, :check_out_date, :guests_number, presence: true
  validate :check_dates
  validate :check_guests_number

  before_validation :generate_code

  def calculate_total_price
    total_price = 0
    current_date = self.check_in_date
  
    while current_date < self.check_out_date
      daily_price = room.current_daily_price(current_date)  
      total_price += daily_price  
      current_date += 1.day
    end
    total_price
  end

  private

  def check_dates
    if room.present? && room.bookings
                          .where.not(id: self.id)
                          .where('(check_in_date <= ? AND check_out_date >= ?) OR (check_in_date <= ? AND check_out_date >= ?) OR (check_in_date >= ? AND check_out_date <= ?)',
                                  self.check_out_date, self.check_in_date,
                                  self.check_in_date, self.check_out_date,
                                  self.check_in_date, self.check_out_date)
                          .exists?
      errors.add(:base, 'O quarto não está disponível para o período selecionado.')
    end
  end

  def check_guests_number 
    if room.present? && self.guests_number && self.guests_number > room.max_guest
      errors.add(:guests_number, ' ultrapassa o permitido para o quarto.')
    end
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

end

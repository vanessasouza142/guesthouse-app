class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one :review
  has_one :guesthouse, through: :room
  enum status: {pending: 0, in_progress: 2, finished: 4, canceled: 6}
  
  validates :check_in_date, :check_out_date, :guests_number, presence: true
  validates :payment_amount, :payment_method, presence: true, if: :register_payment_action?
  validate :check_dates
  validate :check_guests_number
  attr_accessor :register_payment_context

  before_validation :generate_code, on: :create

  def allow_check_in
    if Date.today >= self.check_in_date
      self.in_progress!
      self.update(check_in_done: Time.current)
      return true
    else
      return false
    end
  end

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

  def calculate_payment_amount
    total_price = 0
    current_date = self.check_in_done.to_date

    while current_date < self.check_out_done.to_date
      daily_price = room.current_daily_price(current_date)  
      total_price += daily_price  
      current_date += 1.day
    end

    if self.check_out_done.strftime('%H:%M') > guesthouse.check_out.strftime('%H:%M')
      total_price += room.current_daily_price(self.check_out_done)
    end
    total_price
  end

  def host_cancel_booking
    if Date.today >= (self.check_in_date + 2)
      true
    else
      false
    end
  end

  def guest_cancel_booking
    if Date.today <= (self.check_in_date - 7)
      true
    else
      false
    end
  end

  private

  def check_dates
    if room.present? && room.bookings.where.not(id: self.id)
                          .where('(check_in_date <= ? AND check_out_date >= ?) OR (check_in_date <= ? AND check_out_date >= ?) OR 
                          (check_in_date >= ? AND check_out_date <= ?)',
                          self.check_out_date, self.check_in_date, self.check_in_date, self.check_out_date,
                          self.check_in_date, self.check_out_date).exists?
      errors.add(:base, 'O quarto não está disponível para o período selecionado.')
    end
    if self.check_in_date.present? && self.check_out_date.present?
      errors.add(:check_in_date, ' deve ser anterior à data de saída') if self.check_in_date > self.check_out_date
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

  def register_payment_action?
    register_payment_context.present?
  end

end

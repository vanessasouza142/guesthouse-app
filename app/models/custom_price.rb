class CustomPrice < ApplicationRecord
  belongs_to :room

  validates :begin_date, :end_date, :price, presence: true
  validate :no_date_overlap
  validate :dates_order

  private

  def no_date_overlap
    if room.custom_prices.where.not(id: self.id).where('end_date >= ? AND begin_date <= ?', self.begin_date, self.end_date).exists?
      errors.add(:base, 'Já existe um preço personalizado para o quarto nesse período')
    end
  end

  def dates_order
    if self.begin_date.present? && self.end_date.present? && self.begin_date > self.end_date
      errors.add(:begin_date, ' deve ser anterior à data de término')
    end
  end

end

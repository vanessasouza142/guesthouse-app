class CustomPrice < ApplicationRecord
  belongs_to :room

  validates :begin_date, :end_date, :price, presence: true
end

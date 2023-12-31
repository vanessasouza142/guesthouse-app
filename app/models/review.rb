class Review < ApplicationRecord
  belongs_to :booking
  has_one :user, through: :booking
  has_one :guesthouse, through: :booking

  validates :score, :review_text, presence: true
  validates :answer, presence: true, on: :update
end

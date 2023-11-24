class Guesthouse < ApplicationRecord
  belongs_to :user
  has_many :rooms
  has_many :bookings, through: :rooms
  has_many :reviews, through: :bookings
  enum status: {inactive: 0, active: 2}

  validates :corporate_name, :brand_name, :registration_number, :phone_number, :email, :address, :neighborhood, :state, :city, 
            :postal_code, :description, :payment_method, :usage_policy, :check_in, :check_out, presence: true

  def full_address
    "#{address}, #{neighborhood}, #{city} - #{state} CEP: #{postal_code}"
  end

  def self.search(query)
    where("brand_name LIKE ? OR neighborhood LIKE ? OR city LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%").active.order(:brand_name)
  end

  def average_score
    if self.reviews
      score_sum = 0
      score_length = 0
      self.reviews.each do |review|
        score_sum += review.score
        score_length += 1
      end
      score_sum / score_length.to_f
    end
  end

end

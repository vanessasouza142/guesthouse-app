class Guesthouse < ApplicationRecord
  belongs_to :user

  validates :corporate_name, :brand_name, :registration_number, :phone_number, :email, :address, :neighborhood, :state, :city, 
            :postal_code, :description, :payment_method, :pet_agreement, :usage_policy, :check_in, :check_out, presence: true

  def full_address
    "#{address}, #{neighborhood}, #{city} - #{state} CEP: #{postal_code}"
  end
end
class RemovePrecisionAndScaleFromPaymentAmount < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :payment_amount, :decimal
  end
end

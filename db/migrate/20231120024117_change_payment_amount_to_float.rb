class ChangePaymentAmountToFloat < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :payment_amount, :float
  end
end

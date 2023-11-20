class ChangePaymentAmountToInteger < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :payment_amount, :integer
  end
end

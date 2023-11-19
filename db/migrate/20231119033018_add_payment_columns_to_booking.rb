class AddPaymentColumnsToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :payment_amount, :decimal, precision: 10, scale: 2
    add_column :bookings, :payment_method, :string
  end
end

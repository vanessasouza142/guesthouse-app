class AddColumnsToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :code, :string
    add_column :bookings, :status, :integer, default: 0
  end
end

class AddCheckOutDoneToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :check_out_done, :datetime
  end
end

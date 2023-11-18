class AddCheckInDoneToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :check_in_done, :datetime
  end
end

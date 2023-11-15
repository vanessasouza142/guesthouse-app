class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true, default: 0
      t.date :check_in_date
      t.date :check_out_date
      t.integer :guests_number

      t.timestamps
    end
  end
end

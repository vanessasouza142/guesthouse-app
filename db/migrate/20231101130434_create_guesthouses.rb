class CreateGuesthouses < ActiveRecord::Migration[7.1]
  def change
    create_table :guesthouses do |t|
      t.string :corporate_name
      t.string :brand_name
      t.string :registration_number
      t.string :phone_number
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :state
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end

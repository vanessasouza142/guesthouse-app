class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.float :area
      t.integer :max_guest
      t.float :daily_price
      t.string :bathroom
      t.string :balcony
      t.string :air_conditioner
      t.string :tv
      t.string :wardrobe
      t.string :safe
      t.string :accessible
      t.references :guesthouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end

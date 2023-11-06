class RenameDailyPriceTodefaultPriceInRooms < ActiveRecord::Migration[7.1]
  def change
    rename_column :rooms, :daily_price, :default_price
  end
end

class ChangeColumnsToRooms < ActiveRecord::Migration[7.1]
  def change
    change_column :rooms, :area, :integer
    change_column :rooms, :daily_price, :integer
    change_column :rooms, :bathroom, :boolean
    change_column :rooms, :balcony, :boolean
    change_column :rooms, :air_conditioner, :boolean
    change_column :rooms, :tv, :boolean
    change_column :rooms, :wardrobe, :boolean
    change_column :rooms, :safe, :boolean
    change_column :rooms, :accessible, :boolean
  end
end

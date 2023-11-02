class ChangeColumnsToGuesthouse < ActiveRecord::Migration[7.1]
  def change
    change_column :guesthouses, :description, :text
    change_column :guesthouses, :usage_policy, :text
    change_column :guesthouses, :check_in, :time
    change_column :guesthouses, :check_out, :time
  end
end

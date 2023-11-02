class AddColumnsToGuesthouse < ActiveRecord::Migration[7.1]
  def change
    add_column :guesthouses, :description, :string
    add_column :guesthouses, :payment_method, :string
    add_column :guesthouses, :pet_agreement, :string
    add_column :guesthouses, :usage_policy, :string
    add_column :guesthouses, :check_in, :datetime
    add_column :guesthouses, :check_out, :datetime
  end
end

class AddCpfToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :cpf, :integer
  end
end

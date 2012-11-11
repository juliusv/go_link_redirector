class AddColumnsToLinks < ActiveRecord::Migration
  def change
    add_column :links, :owner_email, :string
    add_column :links, :last_change_email, :string
  end
end

class AddIndexToShortName < ActiveRecord::Migration
  def change
    add_index :links, :short_name, unique: true
  end
end

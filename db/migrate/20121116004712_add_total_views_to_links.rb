class AddTotalViewsToLinks < ActiveRecord::Migration
  def change
    add_column :links, :views, :integer, default: 0
  end
end

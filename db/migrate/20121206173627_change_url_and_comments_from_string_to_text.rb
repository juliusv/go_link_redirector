class ChangeUrlAndCommentsFromStringToText < ActiveRecord::Migration
  def up
    change_column :links, :url, :text, :limit => nil
    change_column :links, :comments, :text, :limit => nil
  end

  def down
    change_column :links, :url, :string
    change_column :links, :comments, :string
  end
end

class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :short_name
      t.string :url
      t.string :comments

      t.timestamps
    end
  end
end

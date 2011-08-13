class CreateAdvertises < ActiveRecord::Migration
  def self.up
    create_table :advertises do |t|
      t.integer :client_id,   :null => false
      t.string :resource_url
      t.decimal :price,       :default => 0
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end

  def self.down
    drop_table :advertises
  end
end

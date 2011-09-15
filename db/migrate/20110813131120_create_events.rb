class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name,               :null => false
      t.text :description
      t.datetime :active_time_start
      t.datetime :active_time_end
      t.string :city
      t.string :country,            :null => false
      t.string :address
      t.integer :times_watched,     :default => 0
      t.integer :liked_count,       :default => 0
      t.boolean :approved,          :default => false
      t.integer :submitter_id
      t.string :submitter_type

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end

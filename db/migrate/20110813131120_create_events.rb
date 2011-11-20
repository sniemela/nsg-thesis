class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name,               :null => false
      t.text :description
      t.datetime :active_time_start
      t.datetime :active_time_end
      t.string :country,            :null => false
      t.string :address
      t.string :city
      t.string :address_and_city
      t.integer :times_watched,     :default => 0
      t.integer :liked_count,       :default => 0
      t.boolean :approved,          :default => false
      t.integer :submitter_id
      t.string :submitter_type
      t.float :longitude
      t.float :latitude
      t.string :picture_file_name
      t.string :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end

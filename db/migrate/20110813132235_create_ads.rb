class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.integer :client_id,   :null => false
      t.decimal :price,       :default => 0
      t.datetime :start_time
      t.datetime :end_time
      t.string :media_file_name
      t.string :media_content_type
      t.integer :media_file_size
      t.datetime :media_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :advertises
  end
end

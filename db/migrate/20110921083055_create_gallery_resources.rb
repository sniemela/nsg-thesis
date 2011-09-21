class CreateGalleryResources < ActiveRecord::Migration
  def change
    create_table :gallery_resources do |t|
      t.integer :gallery_id
      t.string :resource_file_name
      t.string :resource_content_type
      t.integer :resource_file_size
      t.datetime :resource_updated_at
      t.string :name
      t.text :description
      t.integer :times_watched
      t.integer :liked_count

      t.timestamps
    end
    
    add_index :gallery_resources, :gallery_id
  end
end

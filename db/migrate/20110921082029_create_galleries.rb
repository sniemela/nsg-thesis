class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.integer :event_id
      t.string :name
      t.string :description
      t.integer :times_watched
      t.integer :liked_count

      t.timestamps
    end
    
    add_index :galleries, :event_id
  end
end

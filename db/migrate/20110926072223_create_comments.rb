class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.integer :commentable_type
      t.integer :user_id
      t.text :body
      t.references :event

      t.timestamps
    end
    
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :user_id
    add_index :comments, :event_id
  end
end

class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name,             :null => false
      t.integer :client_type_id,  :null => false
      t.integer :user_id
      t.text :description
      t.string :address
      t.string :country
      t.boolean :confirmed,        :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end

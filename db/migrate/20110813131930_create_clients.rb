class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name,             :null => false
      t.integer :client_type_id,  :null => false
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end

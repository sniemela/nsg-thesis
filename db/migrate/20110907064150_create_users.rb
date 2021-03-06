class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :client_id
      t.string :email
      t.string :avatar
      t.boolean :admin

      t.timestamps
    end
  end
end

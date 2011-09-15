class CreateShowtimes < ActiveRecord::Migration
  def change
    create_table :showtimes do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :event_id

      t.timestamps
    end
  end
end

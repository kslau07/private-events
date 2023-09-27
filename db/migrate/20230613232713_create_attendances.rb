class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.integer :attendee_id, null: false
      t.integer :attended_event_id, null: false

      t.timestamps
    end
  end
end

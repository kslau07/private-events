class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.date :event_date, null: false
      t.string :description, :string, null: false

      t.timestamps
    end
  end
end

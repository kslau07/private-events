class AddRefCreatorInEvents < ActiveRecord::Migration[7.0]
  def change
    add_reference :events, :creator, foreign_key: { to_table: :users }, null: false, index: true
  end
end

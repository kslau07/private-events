class AddLocationToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :location, :string, null: false
  end
end

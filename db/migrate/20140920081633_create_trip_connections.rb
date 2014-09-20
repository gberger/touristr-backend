class CreateTripConnections < ActiveRecord::Migration
  def change
    create_table :trip_connections, id: false, force: true do |t|
      t.integer :trip_a_id, null: false
      t.integer :trip_b_id, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end

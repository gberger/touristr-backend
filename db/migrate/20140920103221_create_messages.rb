
class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :trip_a_id
      t.integer :trip_b_id
      t.text :msg

      t.timestamps
    end
  end
end

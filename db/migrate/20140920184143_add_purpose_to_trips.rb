class AddPurposeToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :purpose, :text
  end
end

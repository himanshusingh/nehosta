class AddIndexToBookings < ActiveRecord::Migration
  def change
  	add_index :bookings, [:guest_id, :space_id], unique: true
  end
end

class AddIndexToBookingRequests < ActiveRecord::Migration
  def change
  	add_index :booking_requests, [:guest_id, :space_id], unique: true
  end
end

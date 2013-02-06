class AddGuestsToBookingRequests < ActiveRecord::Migration
  def change
  	add_column :booking_requests, :guests, :integer, default: 1
  end
end

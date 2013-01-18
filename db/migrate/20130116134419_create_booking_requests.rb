class CreateBookingRequests < ActiveRecord::Migration
  def change
    create_table :booking_requests do |t|
      t.integer :space_id
      t.integer :guest_id
      t.integer :host_id
      t.date :start_date
      t.date :end_date
      t.float :amount
      t.float :fees
      t.float :rent
      t.string :description
      t.timestamps
    end
    add_index :booking_requests, :space_id
    add_index :booking_requests, :guest_id
    add_index :booking_requests, :host_id
    add_index :booking_requests, [:start_date, :end_date]
  end
end

class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :space_id
      t.integer :guest_id
      t.integer :host_id
      t.date :start_date
      t.date :end_date
      t.float :amount
      t.float :fees
      t.float :rent
      t.timestamps
    end
    add_index :bookings, :space_id
    add_index :bookings, :guest_id
    add_index :bookings, :host_id
    add_index :bookings, [:start_date, :end_date]
  end
end

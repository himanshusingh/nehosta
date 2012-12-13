class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
    	t.integer :user_id
    	t.string :name
    	t.text :description
    	t.text :rules
    	t.string :street_address
    	t.string :locality
    	t.string :city
    	t.string :country
    	t.integer :pincode
    	t.integer :capacity
    	t.integer :bedrooms
    	t.integer :bathrooms
      	t.timestamps
    end
    add_index :spaces, :user_id
    add_index :spaces, :city
  end
end

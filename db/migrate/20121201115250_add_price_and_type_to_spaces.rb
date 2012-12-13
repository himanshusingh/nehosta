class AddPriceAndTypeToSpaces < ActiveRecord::Migration
  def change
  	add_column :spaces, :price, :float
  	add_column :spaces, :room_type, :string
  end
end

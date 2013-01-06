class AddAmenitiesSizeAndDirectionsToSpaces < ActiveRecord::Migration
  def change
  	add_column :spaces, :amenities, :string
  	add_column :spaces, :size, :float
  	add_column :spaces, :directions, :text
  end
end

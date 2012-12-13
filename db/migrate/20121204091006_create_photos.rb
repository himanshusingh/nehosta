class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.string :caption, default: ""
    	t.timestamps
    end
    add_attachment :photos, :picture
  end
end

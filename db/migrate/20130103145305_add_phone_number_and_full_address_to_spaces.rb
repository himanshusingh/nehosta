class AddPhoneNumberAndFullAddressToSpaces < ActiveRecord::Migration
  def change
  	add_column :spaces, :phone_number, :integer
  	add_column :spaces, :full_address, :text
  end
end

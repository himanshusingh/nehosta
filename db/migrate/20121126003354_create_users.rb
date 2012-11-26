class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.text :description
      t.string :location
      t.date :birthday
      t.string :sex
      t.string :provider
      t.string :uid
      t.string :fb_url

      t.timestamps
    end
  end
end

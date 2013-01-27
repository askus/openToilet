class CreateToilets < ActiveRecord::Migration
  def change
    create_table :toilets do |t|
      t.string :name 
      t.text :address
      t.integer :price => 0
      t.boolean :has_male, :has_female, :has_both, :has_family, :has_free_access, :gmaps
      t.float :latitude, :longitude
      t.timestamps
    end
  end
end

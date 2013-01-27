class CreateToiletRatings < ActiveRecord::Migration
  def change
    create_table :toilet_ratings do |t|
      t.integer :toilet_id
      t.integer :cleanness
      t.integer :safety
      t.integer :privacy
      t.integer :comfort
      t.boolean :has_hook
      t.boolean :has_tissue
      t.text :comment

      t.timestamps
    end
  end
end

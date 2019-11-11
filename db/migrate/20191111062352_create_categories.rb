class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string   "name"           
			t.string   "description"    
			t.integer  "rate_per_night"
      t.timestamps null: false
    end
  end
end

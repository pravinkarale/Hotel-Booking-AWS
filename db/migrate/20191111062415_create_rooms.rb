class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer  "category_id" 
			t.string   "room_type"
			t.string   "room_no"
      t.timestamps null: false
    end
  end
end

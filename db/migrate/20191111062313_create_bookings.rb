class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer  "category_id" 
			t.integer  "room_id"     
			t.integer  "user_id"     
			t.date     "from_date"
			t.date     "to_date"
      t.timestamps null: false
    end
  end
end

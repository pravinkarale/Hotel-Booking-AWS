class Category < ActiveRecord::Base
	has_many :rooms
	has_many :bookings
end

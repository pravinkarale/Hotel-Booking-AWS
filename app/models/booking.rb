class Booking < ActiveRecord::Base
	attr_accessor :room_type

	validates :from_date, presence: {:message => "Please select start date"}
	validates :to_date, presence: {:message => "Please select end date"}
	validates :room_type, presence: {:message => "Please select room type"}
	# validates :room_id, :presence => true 
	validates :user_id, :presence => true 
	# validates :quantity, :presence => true 
	validate :validate_booking_date
	belongs_to :category
	has_many :rooms
	belongs_to :user

	private
		
		def validate_booking_date
			if self.from_date.present? && self.to_date.present? && (self.from_date < Date.today || self.to_date < Date.today )
				errors.add(:from_date, "Please select future dates" )
			elsif (self.from_date.present? && self.to_date.present? && (self.from_date > self.to_date))	
				errors.add(:from_date, "End date should be greater than start date ")
			elsif self.to_date.present? && (self.to_date > (Date.today >> 6))
				errors.add(:to_date, "Booking allow only 6 months in advance")
			end
		end		
end

class BookingsController < ApplicationController
	
	before_filter :authenticate_user!, :only => [:create]

	def new		
		session[:category_id] = params[:category_id] if params[:category_id].present?
		@category = Category.find(session[:category_id])
		@booking = Booking.new 
	end	

	def index
		@bookings = current_user.bookings if current_user.present?
	end

	def create
			@booking = Booking.new(booking_params)
			
			all_rooms_of_type_n_category = Room.where(room_type: params[:booking][:room_type], category_id: params[:booking][:category_id]).pluck(:id)
			## find category wise room booked for date period 			
			category_booked_rooms  = Booking.find_by_sql("SELECT `bookings`.* FROM `bookings` WHERE category_id = #{params[:booking][:category_id]} and ((`bookings`.`to_date` BETWEEN '#{params[:booking][:from_date].to_date}' AND '#{params[:booking][:to_date].to_date}') OR (`bookings`.`from_date` BETWEEN '#{params[:booking][:from_date].to_date}' AND '#{params[:booking][:to_date].to_date}'))") rescue nil
			category_booked_room_ids = category_booked_rooms.map(&:room_id)
			available_rooms = all_rooms_of_type_n_category - category_booked_room_ids rescue 0 
			@category = Category.find	(session[:category_id]) if session[:category_id].present?
			
				@booking.room_id = available_rooms.first if available_rooms.present?
				if @booking.save
					flash[:notice] = "Booking Save"
					session.delete(:category_id) 
					redirect_to categories_path
				else
					render :new
				end
			# else
			# 	flash[:notice] = "No Rooms Available"
			# 	render :new	
			# end		 
	end

	def get_available_booking
		bookings  = Booking.find_by_sql("SELECT `bookings`.* FROM `bookings` WHERE category_id = #{params[:category_id]} and ((`bookings`.`to_date` BETWEEN '#{params[:start_date].to_date}' AND '#{params[:end_date].to_date}') OR (`bookings`.`from_date` BETWEEN '#{params[:start_date].to_date}' AND '#{params[:end_date].to_date}'))")
		@category = Category.find(params[:category_id])
		booked_room_ids = bookings.map(&:room_id)
		available_category_room_ids = @category.rooms.pluck(:id) - booked_room_ids
		@available_category_names = Room.where(id: available_category_room_ids).pluck(:room_type).uniq
	end

	def booking_params
		params.require(:booking).permit!
	end
end

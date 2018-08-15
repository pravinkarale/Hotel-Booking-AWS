class Api::V1::BookingsController < ApplicationController

	skip_before_filter :authenticate_user!

	def index
		if params[:start_date].blank? or params[:end_date].blank? or params[:category_id].blank? 
      render :status => 400,:json => {:status=>"Failure",:message=>"Please provide from_date, to_date and category_id"}
      return
    end
    bookings  = Booking.find_by_sql("SELECT `bookings`.* FROM `bookings` WHERE category_id = #{params[:category_id]} and ((`bookings`.`to_date` BETWEEN '#{params[:start_date].to_date}' AND '#{params[:end_date].to_date}') OR (`bookings`.`from_date` BETWEEN '#{params[:start_date].to_date}' AND '#{params[:end_date].to_date}'))")
		@category = Category.find(params[:category_id])
		booked_room_ids = bookings.map(&:room_id)
		available_category_room_ids = @category.rooms.pluck(:id) - booked_room_ids
		@available_category_names = Room.where(id: available_category_room_ids).pluck(:room_type).uniq
		if @available_category_names.present?
			render :status => 200,:json => {:status=>"Success",:room_type=> @available_category_names}
		else
			render :status => 200,:json => {:status=>"Success",:msg=> "No Rooms Available"}
		end	
	end
end

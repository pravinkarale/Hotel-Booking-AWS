class CategoriesController < ApplicationController
	def index
		session.delete(:category_id) if session[:category_id].present?
		@categories = Category.all
	end

	def show
		@category  = Category.find(params[:id])
	end
end

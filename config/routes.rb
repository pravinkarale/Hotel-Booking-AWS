Rails.application.routes.draw do
  devise_for :users
  
  resources :categories, :rooms, :bookings
  root "categories#index"
  get 'get_available_booking' => "bookings#get_available_booking"
  get "/check_availability" => "api/v1/controller#action"

  namespace :api do
    namespace :v1 do
      resources :bookings
    end
  end
  get '*path' => redirect('/') # redirect to root path if url is invalid
end

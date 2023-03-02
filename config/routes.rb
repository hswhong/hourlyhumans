Rails.application.routes.draw do
  devise_for :users
  root to: "pages#landing_page"
  resources :users do
    resources :bookings
  end

  get "/humans" => "pages#home"

  # get "users/:id", to: "booking/id/users/id"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Define customer route for requests
  get "/users/:user_id/bookings/:id/accept", to: "bookings#accepted", as: :accepted
  get "/users/:user_id/bookings/:id/reject", to: "bookings#rejected", as: :rejected

end

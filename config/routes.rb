Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  # get '/' => 'hom/#index'
  root to: 'home#index'
  get '/about' => 'about#index'
end

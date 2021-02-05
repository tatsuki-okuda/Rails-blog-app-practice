Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  # get '/' => 'home/#index'
  root to: 'articles#index'

  # get '/about' => 'about#index'

  # showメソッドに限りルーティングをしてくれる
  resources :articles, only: [:show, :new, :create, :edit, :update, :destroy]
end

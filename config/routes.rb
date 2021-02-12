Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get '/' => 'home/#index'
  root to: 'articles#index'

  # get '/about' => 'about#index'

  # showメソッドに限りルーティングをしてくれる
  # do end　でarticleに紐づくURLになる　→　article/comennts/〜
  resources :articles do
    resources :comments,only: [:new, :create]
  end
end

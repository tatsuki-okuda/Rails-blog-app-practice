Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get '/' => 'home/#index'
  root to: 'articles#index'
  resource :timeline, only: [:show]

  # get '/about' => 'about#index'

  # showメソッドに限りルーティングをしてくれる
  # do end　でarticleに紐づくURLになる　→　article/comennts/〜
  resources :articles do
    resources :comments,only: [:index, :new, :create]

    # 一人のライクは一つの記事に対して一つなので、単数扱い
    resource :like,only: [:show, :create, :destroy]
  end

  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
  end

  resource :profile, only: [ :show, :edit, :update]
  resources :favorites, only: [ :index ]
end

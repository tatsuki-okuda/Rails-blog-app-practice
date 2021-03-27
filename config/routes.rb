require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get '/' => 'home/#index'
  root to: 'articles#index'
  # resource :timeline, only: [:show]

  # get '/about' => 'about#index'

  # showメソッドに限りルーティングをしてくれる
  # do end　でarticleに紐づくURLになる　→　article/comennts/〜
  resources :articles
  # resources :articles do
  #   resources :comments,only: [:index, :new, :create]

  #   # 独自のメソッドを付け加えるとき
  #   # member do
  #   #   post :like
  #   # end

  #   # 一人のライクは一つの記事に対して一つなので、単数扱い
  #   resource :like,only: [:show, :create, :destroy]
  # end

  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
  end

  # resource :profile, only: [ :show, :edit, :update]

  # resource :profile, only: [ :show, :edit, :update] do
  #   collection do
  #     post 'publish'
  #   end
  # end

  # resources :favorites, only: [ :index ]

  # module
  scope module: :apps do
    resources :favorites, only: [ :index ]
    resource :profile, only: [ :show, :edit, :update]
    resource :timeline, only: [:show]
  end

  # namespaceでコントローラーのディレクトリを変える
  # デフォルトのフォーマットを指定
  namespace :api, defaults: {format: :json} do
    # urlは変えないようにする
    scope '/articles/:article_id' do
      resources :comments, only: [:index, :create]
      resource :like, only: [:show, :create, :destroy]
    end
  end

end

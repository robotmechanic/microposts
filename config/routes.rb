Rails.application.routes.draw do
  
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #get 'followers/:id', to: 'users#followers'
  #get 'following/:id', to: 'users#following' 
  #see different method below
  
  resources :users do
    member do
      get :following
      get :follower
    end
    #collection do
    #  post 'hoge'
    #  get 'hige'
    #end  
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end

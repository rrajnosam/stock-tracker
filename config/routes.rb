Rails.application.routes.draw do
  devise_for :users
  resources :friendships, only: [:create, :destroy]
  resources :user_stocks, only: [:create, :destroy]

    root to: 'welcome#index'
    get 'my_portfolio', to: 'users#my_portfolio'
    get 'search_stock', to: 'stocks#search'
    get 'my_friends', to: 'users#my_friends'
    get 'search_friends', to: 'users#search'
  resources :users, only: [:show]

end

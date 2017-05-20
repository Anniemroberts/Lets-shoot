Rails.application.routes.draw do
  resources :chatrooms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'jobs#index'
  mount ActionCable.server => '/cable'
  patch '/auth' => 'admin/dashboard#auth', as: :auth

  get :shooting, to: 'jobs#shooting'
  get :network, to: 'chatrooms#network'
  get :hire, to: 'submissions#hire'

  namespace :admin do
    resources :dashboard, only: [:create, :destroy, :index, :auth]
  end

  resources :search do
    collection do
      get :autocomplete
      get :results
    end
  end

  resources :jobs, shallow: true do
    get :jobs_posted
    resources :submissions, only: [:create, :destroy, :index], as: :applications
  end

  resources :users, only: [:new, :create, :edit, :update] do
    get :profile
    resources :submissions, only: [:index, :hire], as: :applications
  end

  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end

  resources :direct_messages, only: [:show]

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  devise_for :users, controllers: {sessions: "sessions"}

  resources :friendships, only: [:create, :update, :destroy]

  match "auth/facebook/callback/", to: "sessions#create", via: [:get, :post]
  match "auth/failure", to: redirect("/"), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end

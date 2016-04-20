Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :attachments
    resources :categories
    resources :departments
    resources :opportunities
    resources :questions
    resources :saved_searches

    root to: 'users#index'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  root to: 'home#index'

  resources :saved_searches, only: [:create, :destroy]

  resources :opportunities do
    collection do
      get 'feed'
      get 'pending'
    end

    member do
      get 'submit'
      post 'approve'
      post 'subscribe'
    end

    resources :questions, only: [:create, :update, :destroy]
    resources :attachments, only: [:create, :destroy]
  end
end

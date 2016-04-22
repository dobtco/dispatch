Rails.application.routes.draw do
  root to: 'home#index'

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

  devise_scope :user do
    get 'users/confirm' => 'users/registrations#confirm'
  end

  DispatchConfiguration.static_pages.each do |x|
    get x['path'] => "static##{x['path']}"
  end

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
      post 'request_approval'
    end

    resources :questions, only: [:create, :update, :destroy]
    resources :attachments, only: [:create, :destroy]
  end
end

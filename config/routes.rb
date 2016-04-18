Rails.application.routes.draw do
  mount DobtAuth::Engine, at: 'dobt_hooks', as: 'dobt_auth'

  root to: 'home#index'
end

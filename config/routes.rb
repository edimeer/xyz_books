Rails.application.routes.draw do
  root 'home#index'
  get 'books/:id', to: 'books#show', as: 'books'

  namespace :api do
    resources :books, only: :show
  end

  match '/404', to: 'errors#not_found', via: :all
  match '*path', to: 'errors#not_found', via: :all
end

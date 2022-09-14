Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.htmlA
  resources :courses do
    member do
      post :enroll
    end
  end
  resources :profiles
  root 'courses#index'
  # Defines the root path route ("/")
  # root "articles#index"
end

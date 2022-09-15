Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.htmlA
  resources :courses do
    collection do
      get :filter
    end
    member do
      post :enroll
      patch :mark_as
    end
  end
  resources :profiles
  root 'profiles#show'
  # Defines the root path route ("/")
  # root "articles#index"
end

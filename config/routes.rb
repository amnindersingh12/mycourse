Rails.application.routes.draw do
  # devise_for :users
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.htmlA

  # resources :products do
  #   resources :comments
  #   resources :sales do
  #     get 'recent', :on => :collection
  #   end
  # end
  # namespace :admin do
  resources :courses do
    member do
      post :enroll
      patch :mark_as
    end
  end
  # end
  resources :profiles, only: %i[show index]

  root 'homepages#index'

  # namespace :admin do
  #   # /admin/photos/
  #   # admin_photos_new
  #   # admin/photds#new
  #   # url
  #   # admin.kiprosh.com
  #     resources :photos, params: :aka
  #   end
  # end
end

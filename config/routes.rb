Rails.application.routes.draw do
  devise_for :users

  root 'bookmarks#index'
  resources :bookmarks do
  	get 'liked', on: :collection
  	resources :likes
  end 


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

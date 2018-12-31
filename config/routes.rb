Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do
    root to: "devise/sessions#new"
  end
  resources :bookmarks do
  	get 'liked', on: :collection
  	get 'archived', on: :collection
    get 'search', on: :collection 
  	member do 
  	  patch :toggle_active
  	end
  	resources :likes, only: [:create, :destroy]
  end 


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

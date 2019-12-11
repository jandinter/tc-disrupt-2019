Rails.application.routes.draw do
  resources :maps

  root to: "maps#index"

  resources :updates, :defaults => { :format => :json }

  # resources :updates
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

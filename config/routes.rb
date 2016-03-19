Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :trainers
#  patch 'pokemons/capture', to: 'pokemons#capture', as: 'capture'
  patch 'pokemons/:id', to: 'pokemons#capture', as: 'capture'
  patch 'damage', to: 'pokemons#damage', as: 'damage'
  get "pokemons/new", to: "pokemons#new"
  post "pokemons", to: "pokemons#create"
  resources :trainers 

end

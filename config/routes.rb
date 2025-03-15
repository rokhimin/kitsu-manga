Rails.application.routes.draw do
  # Devise routes for users
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  # Static page for confirmation instructions
  get '/confirmation_instructions', to: 'static_pages#confirmation_instructions', as: :confirmation_instructions

  # Homepage accessible to everyone
  root to: 'home#index'

  # 404 page not found
  match "/404", to: "errors#not_found", via: :all

  # Admin area
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    get 'users/:id/edit', to: 'dashboard#edit_user', as: 'edit_user'
    patch 'users/:id', to: 'dashboard#update_user', as: 'update_user'
    delete 'users/:id', to: 'dashboard#delete_user', as: 'delete_user'
  end

  # Member area
  namespace :member do
    get 'dashboard', to: 'dashboard#index'
  end

  # manga
  resources :mangas, path: 'manga', param: :id do
    get "chapter-:chapter_number", to: "chapters#show", as: "chapter"

    # update chapter
    get "chapter-:chapter_number/edit", to: "chapters#edit", as: "edit_chapter"
    patch "chapter-:chapter_number", to: "chapters#update"
  
    # new chapter
    get "chapter/new", to: "chapters#new", as: "new_chapter"
    post "chapter", to: "chapters#create", as: "chapter_create"
      
    # delete chapter
    delete "chapter-:chapter_number", to: "chapters#destroy", as: "delete_chapter"
  end

end

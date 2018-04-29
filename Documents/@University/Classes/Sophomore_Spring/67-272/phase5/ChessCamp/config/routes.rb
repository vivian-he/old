Rails.application.routes.draw do
  get 'families/index'

  get 'families/show'

  get 'families/edit'

  get 'families/new'

  get 'families/create'

  get 'families/update'

  get 'families/destroy'

  get 'students/index'

  get 'students/show'

  get 'students/edit'

  get 'students/new'

  get 'students/create'

  get 'students/update'

  get 'students/destroy'

  get 'registrations/index'

  get 'registrations/show'

  get 'registrations/edit'

  get 'registrations/new'

  get 'registrations/create'

  get 'registrations/update'

  get 'registrations/destroy'

  get 'credit_cards/edit'

  get 'credit_cards/new'

  get 'credit_cards/create'

  get 'credit_cards/update'

  get 'credit_cards/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/search', to: 'home#search', as: :search
  root 'home#index'

  # Routes for main resources
  resources :camps
  resources :instructors
  resources :locations
  resources :curriculums

  # Authentication routes
  resources :sessions
  resources :users
  get 'users/new', to: 'users#new', as: :signup
  get 'user/edit', to: 'users#edit', as: :edit_current_user
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout

  # Routes for managing camp instructors
  get 'camps/:id/instructors', to: 'camps#instructors', as: :camp_instructors
  post 'camps/:id/instructors', to: 'camp_instructors#create', as: :create_instructor
  delete 'camps/:id/instructors/:instructor_id', to: 'camp_instructors#destroy', as: :remove_instructor
  
  # You can have the root of your site routed with 'root'
  root 'home#index'
end









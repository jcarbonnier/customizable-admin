CustomizableAdmin::Engine.routes.draw do

  #----- Concerns
  concern :positionable do
    get 'manage_positions', on: :collection
    post 'update_positions', on: :collection
  end

  #----- Devise
  devise_for :users,
             class_name: "CustomizableAdmin::Settings::User",
             controllers: {
                 confirmations: 'customizable_admin/devise/confirmations',
                 passwords: 'customizable_admin/devise/passwords',
                 registrations: 'customizable_admin/devise/registrations',
                 sessions: 'customizable_admin/devise/sessions',
                 unlocks: 'customizable_admin/devise/unlocks'
             }

  #----- Settings namespace
  namespace :settings do
    resources :menus, concerns: :positionable
    resources :roles
    resources :users do
      get 'permissions', on: :member
    end
    resources :permissions do
      get 'setup_actions_controllers_db', on: :collection
    end
  end

  #----- Administration root
  # root to: "application#home"

  #----- Root
  root to: "home#index"

end

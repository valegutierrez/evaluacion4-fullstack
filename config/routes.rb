Rails.application.routes.draw do
  resources :tasks do
    member do
      get 'finish'
    end
    collection do
      get 'done'
      get 'not_done'
    end
  end
  resources :todos, only: [:show, :edit, :update, :destroy]

  devise_for :users
  root to: 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

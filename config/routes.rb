Rails.application.routes.draw do
  
  devise_for :users,
    controllers: { registrations: 'registrations' }

  root to: 'static_pages#top'
  get "/about" => "static_pages#about", as: "about"
  get "/home" => "static_pages#home", as: "home"
  get "/favorites" => "static_pages#favorites", as: "favorites"
  get "/search" => "search#index", as: "search"
  resources :protocols do
  	resource :protocol_favorites, only: [:create, :destroy]
  end
  resources :discussions do
  	resources :discuss_comments, only: [:create, :destroy]
  	resource :discuss_favorites, only: [:create, :destroy]
  end
  resources :questions do
  	resources :ques_comments, only: [:create, :destroy]
  	resource :ques_favorites, only: [:create, :destroy]
  end
  resources :laboratories, only: [:new, :show, :edit, :update, :create] do
    resources :events, only: [:create, :destroy]
  	resources :lab_tasks, only: [:create, :destroy, :update]
  	resources :lab_members, only: [:new, :index, :create, :update, :destroy]
  	resources :lab_informations do
  		resources :lab_information_comments, only: [:create, :destroy]
  		resource :lab_information_checks, only: [:create, :destroy]
  	end

  	resources :projects, only: [:new, :show, :edit, :update, :create, :destroy] do
  		resources :project_tasks, only: [:create, :destroy, :update]
  		resources :project_members, only: [:new, :index, :create, :update, :destroy]
  		resources :project_informations, only: [:new, :show, :create, :destroy] do
  			resources :project_information_comments, only: [:create, :destroy]
  			resource :project_information_checks, only: [:create, :destroy]
  		end
  	end

  end
end

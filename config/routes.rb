Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  get 'home/index'
  root to: "home#index"
  get 'post/new'
  get 'user/settings'
  get 'roles', to: "user#roles"
  get 'users', to: "user#users"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

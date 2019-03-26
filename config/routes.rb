Rails.application.routes.draw do

  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only:[:index, :show, :new, :create, :destroy] do
    resources :reviews, only:[:new, :create]
  end

  resources :authors, only:[:index, :show, :destroy]
end

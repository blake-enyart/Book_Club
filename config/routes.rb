Rails.application.routes.draw do

  # root 'pages#home'
  # resources :books, only:[:index, :show, :new, :create, :destroy] do
  #   resources :reviews, only:[:new, :create, :destroy]
  # end
  #
  # resources :authors, only:[:index, :show, :destroy]
  #
  # get '/reviews/:username', to: 'reviews#show', as: :user

  get '/', to: 'pages#home', as: :root

  post '/books/:book_id/reviews', to: 'reviews#create', as: :book_reviews
  get '/books/:book_id/reviews/new', to: 'reviews#new', as: :new_book_review
  delete '/books/:book_id/reviews/:id', to: 'reviews#destroy', as: :book_review

  get '/books', to: 'books#index', as: :books
  post '/books', to: 'books#create'
  get '/books/new', to: 'books#new', as: :new_book
  get '/books/:id', to: 'books#show', as: :book
  delete '/books/:id', to: 'books#destroy'

  get '/authors', to: 'authors#index', as: :authors
  get '/authors/:id', to: 'authors#show', as: :author
  delete '/authors/:id', to: 'authors#destroy'

  resources :reviews, only: [:show], as: 'user', param: :username

end

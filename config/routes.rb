Rails.application.routes.draw do
  root to: redirect('/books')
  resources :books do
    member do
      get 'delete'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

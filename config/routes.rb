Rails.application.routes.draw do
  resources :movies do
    member do
      get 'similar'
    end
  end
  root :to => redirect('/movies')
end

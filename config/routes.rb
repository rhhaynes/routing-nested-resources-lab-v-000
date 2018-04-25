Rails.application.routes.draw do
  
  resources :songs
  resources :artists do
    resources :songs, only: [:index, :show]
  end
end

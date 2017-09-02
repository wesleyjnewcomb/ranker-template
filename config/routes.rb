Rails.application.routes.draw do
  root to: 'react_pages#vote'
  get '/vote', to: 'react_pages#vote'
  get '/ladder', to: 'react_pages#ladder'

  namespace :api do
    namespace :v1 do
      resources :ballots, only: [:update] do
        collection do
          get 'random'
        end
      end
    end
  end
end

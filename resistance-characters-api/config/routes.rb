Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, constraints: {format: :json} do
    namespace :v1 do
      post '/login', to: 'sessions#create'

      resources :players, only: [:show, :create, :update]

      resources :games, only: [:show, :create, :update] do
        member do
          put :start
          put :end
          post :join
          delete :disconnect
        end
      end
    end
  end

end

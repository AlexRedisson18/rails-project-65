# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout'

    resources :bulletins, except: %i[destroy] do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    namespace :admin do
      root 'admin#index'

      resources :categories, except: %i[show]
      resources :bulletins, only: %i[index] do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
    end

    resource :profile, only: %i[show]
  end
end

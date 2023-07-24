Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin/dashboard', as: 'rails_admin'
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"
    resources :users,           only: [:index,:edit, :update]
    resources :themes,          only: [:index, :show, :update]
    resources :tier_lists,      only: [:index, :show]
    resources :theme_reports,   only: [:index, :update]
    resources :comment_reports, only: [:index, :update]
  end


  # 顧客用
  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }


  scope module: 'user' do

    root to: "homes#top"
    get "/about" => "homes#about"
    get "/search" => "searches#search"

    resources :themes, only: [:new, :create, :index] do
      resources :tier_lists, only: [:new, :create]
      resources :theme_reports, only: [:create] do
        get 'completion', on: :collection
      end
    end

    resources :tier_lists,except: [:new, :create] do
      resources :comments, only: [:create, :update] do
        resources :comment_reports, only: [:create] do
          get 'completion', on: :collection
        end
      end
      resource :favorites, only: [:create, :destroy]
    end


    resources :users, only: [:show, :edit, :update] do
      collection do
        get 'leave'
        patch 'withdrawal'
      end
      get 'favorite'
    end
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "user/sessions#guest_sign_in"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

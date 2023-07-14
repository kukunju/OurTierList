Rails.application.routes.draw do

  namespace :admin do
    get 'tier_lists/show'
    get 'tier_lists/index'
  end
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"
    resources :users,           only: [:edit, :update]
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

    resources :favorites, only: [:create, :destroy]
    resources :themes, only: [:new, :create, :index] do
      resources :tier_lists, only: [:new, :create]
    end

    resources :tier_lists,except: [:new, :create, :destroy]
    resources :comments, only: [:create, :destroy]

    resources :users, only: [:show, :edit, :update] do
      collection do
        get 'leave'
        patch 'withdrawal'
      end
      get 'favorite'
    end

    resources :theme_reports, only: [:create] do
      get 'completion', on: :collection
    end

    resources :comment_reports, only: [:create] do
      get 'completion', on: :collection
    end

  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

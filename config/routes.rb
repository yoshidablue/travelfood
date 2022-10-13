Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root "homes#top"
    get "about" => "homes#about"
    resources :customers, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers'  => 'relationships#followers',  as: 'followers'
      get "unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
      patch "withdraw" => "customers#withdraw", as: "withdraw"
      member do
        get 'favorites'
      end
    end
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :food_comments, only: [:create, :destroy]
      resource  :favorites,     only: [:create, :destroy]
      collection do
        get 'search'
      end
    end
    resources :rooms,    only: [:create, :index, :show]
    resources :messages, only: [:create]
    resources :groups do
      resources :group_comments, only: [:create, :destroy]
      get "join" => "groups#join"
      delete "all_destroy" => "groups#all_destroy"
    end
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :posts,     only: [:index, :show, :destroy] do
      resources :food_comments, only: [:destroy]
      collection do
        get 'search'
      end
    end
    resources :groups do
      resources :group_comments, only: [:destroy]
      delete "all_destroy" => "groups#all_destroy"
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
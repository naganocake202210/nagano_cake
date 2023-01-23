Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 顧客用def top end

# URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
   registrations: "public/registrations",
   sessions: 'public/sessions'
 }

  # 管理者用
# URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
 }

 namespace :admin do
    resources :genres, only: [:index, :edit]

    root to: 'homes#top'

    resources :customers, only: [:index, :show, :edit, :update]

    resources :items, only: [:new, :create, :index, :show, :update, :edit]

  end


  namespace :public do
    get 'cart_items/index'
  end
  scope module: :public do
    root to: 'homes#top'
    get "/about" => "homes#about", as: "about"

    get "customers/my_page" => "customers#show", as: "my_page"
    get "customers/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
    patch "customers/withdraw" => "customers#withdraw", as: "withdraw"
    resources :customers, only: [:edit, :update]



    resources :items, only: [:index, :show]

    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]

  end


end
Rails.application.routes.draw do
  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}

  devise_for :admin, controllers: {
  sessions:      'admin/sessions',
  passwords:     'admin/passwords',
  registrations: 'admin/registrations'
}


   namespace :admin do
    root 'homes#top'
    resources :genres, except: [:new, :show, :destroy]
    resources :items, except: [:destroy]
    resources :customers, only: [:show, :index, :edit, :update]
    resources :orders, only: [:index, :show]
    get '/customers/:id/orders' => 'orders#index', as: "customer_orders" # 会員詳細 => 注文履歴の表示データを変える用
 end

#customers
  root 'homes#top'
  get '/thanks' => 'homes#thanks'
   get "/homes/about" => "homes#about"
  get '/orders/confirm' => 'orders#confirm', as: 'orders_confirm' #購入確認画面への遷移
  get '/orders/create_order' => 'orders#create_order' #購入確定のアクション
  post '/orders/create_address' => 'orders#create_address' #情報入力画面での配送先登録用のアクション
  delete '/cart_items' => 'cart_items#destroy_all' #カートアイテムを全て削除
  get '/customers/:id/withdraw' => 'customers#withdraw', as: 'withdraw_customer' #退会画面への遷移
  patch '/customers/:id/withdraw' => 'customers#switch', as: 'withdraw_switch_customer' #会員ステータスの切替

  resources :customers, only: [:show, :edit, :update]
  resources :addresses, except: [:new, :show]
  resources :cart_items, except: [:new, :show, :edit]
  resources :items, only: [:index, :show]
  resources :genres, only: [:index] do
  resources :items, only: [:index]


  end

  resources :orders, except: [:edit, :update, :destroy]

 end

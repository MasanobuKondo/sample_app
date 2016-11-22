Rails.application.routes.draw do
  # Sampleへのリンク表示
  get 'link/index'

  # 通話情報トラッキング
  get 'sample/show'

  # V字通話
  get 'conference/index'
  post 'conference/create' => "conference#create"

  # トラッキング
  #post 'call-tracking/forward-call' => 'call-tracking#forward_call', as: :forward_call
  post 'call_tracking/forward_call' => 'call_tracking#forward_call', as: :forward_call
  get 'statistics/leads_by_source' => 'statistics#leads_by_source', as: :leads_by_source
  get 'statistics/leads_by_city' => 'statistics#leads_by_city', as: :leads_by_city
  resources :lead_sources, only: [:create, :edit, :update]
  resources :available_phone_numbers, only: [:index]

  get 'tracking/index'
  get 'tracking/show'

  # ブラウザフォン
  get 'twilio/index'
  get 'twilio/call'
  get 'twilio/dial'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

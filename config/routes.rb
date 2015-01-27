Rails.application.routes.draw do
  root to: 'index#index'

  get 'chromecast', to: 'index#chromecast'
  get 'phone', to: 'index#phone'
end

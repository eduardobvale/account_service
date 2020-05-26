Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  
  resource :account, only: [] do
    member do
      put :update
      get :referrals
    end
  end
end

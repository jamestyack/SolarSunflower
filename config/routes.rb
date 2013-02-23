SolarSunflower::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users

  post "/data_collection", to: 'data_collection#submit'

  #aliased to perhaps save amount of data needed to be hardcoded on client ardruino
  post "/dc", to: 'data_collection#submit'

  get "/dc/index/:site_id", to: 'data_collection#index'

  get "/sites", to: 'sites#index'


end

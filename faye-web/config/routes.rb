FayeWeb::Application.routes.draw do
  root "notices#index"
  resources :notices
end

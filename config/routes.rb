Meiserauth::Engine.routes.draw do
 resources :users
 resource :session, :only => [:new, :create, :destroy]
 root :to => 'application#start'
end

Meiserauth::Engine.routes.draw do
 resources :users
 resource :session, :only => [:new, :create, :destroy]
end


Rails.application.routes.draw do
 mount Meiserauth::Engine, :at => "/meiserauth"
end

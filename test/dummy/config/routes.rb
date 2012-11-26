Rails.application.routes.draw do

  mount Meiserauth::Engine => "/meiserauth"
  
  root :to => 'application#start'
end

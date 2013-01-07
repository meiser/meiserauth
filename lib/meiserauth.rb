require 'meiserauth/engine'
require 'net/ldap'

module Meiserauth

  module ClassMethods
    
  
  end
  
  
  
  module InstanceMethods
   
   def authenticate_user!
    if session[:user_id]
     true
    else
     flash[:notice] = "Erst anmelden"
     session[:return_to] = request.path
     redirect_to meiserauth.new_session_path
     
     #render :text => "Noch anmelden"
     #render :text => 'meiserauth/sessions#new'
     ##root_path#new_session_path
    end
   end
   
  end
  
  
  
  module ActionViewHelper
  
   def current_user
    @current_user ||= Meiserauth::User.find_by_id(session[:user_id]) if session[:user_id]
   end
  
  end



end

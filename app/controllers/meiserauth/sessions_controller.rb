require_dependency "meiserauth/application_controller"

module Meiserauth
  class SessionsController < ApplicationController
  
  
  
    skip_before_filter :authenticate_user!, :only => [:new, :create]
  
    def new
     @user = User.new
    end
  
    def create
      #reset_session
      user = User.ldap_auth(params[:user][:login_or_email], params[:user][:password])
      if user
        user.sign_in_count ||= 0
        user.sign_in_count += 1
  
        old_current, new_current = user.current_sign_in_at, Time.now.utc
        user.last_sign_in_at = old_current || new_current
        user.current_sign_in_at = new_current
  
        old_current, new_current = user.current_sign_in_ip, request.ip
        user.last_sign_in_ip = old_current || new_current
        user.current_sign_in_ip = new_current
  
        user.save(:validate => false)
        session[:user_id] = user.id
        path = session[:return_to] || "/"
  
        redirect_to(path, :notice => t(".signed_in", :scope => :authentification))
      else
        flash[:error] = t(".invalid", :scope => :authentification)
        redirect_to new_session_path
      end
    end
  
    def destroy
     user = User.find_by_id(session[:user_id])
     session[:user_id] = nil
     session[:return_to] = nil
     redirect_to "/", :notice => t(".signed_out", :scope => :authentification)
    end
  
  
  
  
  
  
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  before_filter :authenticate_user!
  
   
  
  def start
   #render :text => "Startbildschirm 1"
  end
  
  def second
   #render :text => "Startbildschirm 2"
  end

  def third
   #render :text => "Startbildschirm 3"
  end

end

class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery

  def index
  	render 'public/index'
  end
 
end

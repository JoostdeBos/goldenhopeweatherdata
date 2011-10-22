class StationsController < ApplicationController
	before_filter :login_required

  def index
    @stations = Station.order("country", "city").page(params[:page]).per(25)
  end

  def show
  	@station = Station.find(params[:id])
  end

  def map
    #it loads quite slow so im limiting it to 300 for now, this should be based on client requested weather data
    @json = Station.where(:country => :MALAYSIA).to_gmaps4rails
  end
  
  @markers = Station.all.to_gmaps4rails
  
end

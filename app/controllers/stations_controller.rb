class StationsController < ApplicationController
	before_filter :login_required
  # MIN_PRECIPITATION = 5
  # MAX_PRECIPITATION = 10
  # MIN_TEMP = 20
  # MAX_TEMP = 30

  def index
    #if we're searching for something
    if params[:search].present?
      #if we're searching with a distance, use that
      if params[:distance].present?
         @stations = Station.near(params[:search], params[:distance], :units => :km, :order => :distance).page(params[:page]).per(25)
        #otherwise, search within 50km
       else
        @stations = Station.near(params[:search], 50, :units => :km, :order => :distance).page(params[:page]).per(25)
      end
    #else show all (paged at 25 stations per page)
    else
      @stations = Station.all.page(params[:page]).per(25)
    end
  end

  def show
  	@station = Station.find(params[:id])
    @measurement = @station.measurements.last
    @all_temps = []
    @all_clouds = []
    #build graph data
      @station.measurements.each do |m|
        @all_temps. << m.temp.round(2)
        @all_clouds << m.cloudcoverage.round(2)
      end
  end

  def map
    @json = Station.where(:measurements.exists => true).limit(1000).to_a.to_gmaps4rails
  end

  def load_chart
    @station = Station.find(params[:station_id]) 
    @measurement = @station.measurements.last
    @all_temps = []
    @all_clouds = []
    #build graph data
    @station.measurements.each do |m|
      @all_temps. << m.temp.round(2)
      @all_clouds << m.cloudcoverage.round(2)
    end
  end
  
end

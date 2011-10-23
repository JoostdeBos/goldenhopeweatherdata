class StationsController < ApplicationController
	before_filter :login_required

  def index
    if params[:search].present?
      @stations = Station.near(params[:search], params[:distance], :units => :km, :order => :distance).page(params[:page]).per(25)
    else
      @stations = Station.order("country", "city").page(params[:page]).per(25)
    end
  end

  def show
  	@station = Station.find(params[:id])

    weatherdata = @station.weatherdata.last
    @last_updated = weatherdata["time"]
    @temp = weatherdata["temp"].round(2)
    @dewpoint = weatherdata["dewpoint"].round(2)
    @airpressure = weatherdata["airpressure"].round(2)
    @stationpressure = weatherdata["stationpressure"].round(2)
    @visibility = weatherdata["visibility"].round(2)
    @windspeed = weatherdata["windspeed"].round(2)
    @precipitation = weatherdata["precipitation"].round(2)
    @snow = weatherdata["snow"].round(2)
    @cloudcoverage = weatherdata["cloudcoverage"].round(2)
    @winddir = weatherdata["winddir"]

    # returns an array with all the temperatures (for graph)
    data = @station.weatherdata
    @all_temps = []
    @all_times = []
    @all_clouds = []
    data.each do |t|
      @all_temps << t["temp"].round(2)
      @all_temps << "," #Yes, i'm a bad person and i should feel bad.
      @all_times << t["time"]
      @all_times << ","
      @all_clouds << t["cloudcoverage"].round(1)
      @all_clouds << "," #hackedyhack
    end
  end

  def map
    t = Station.arel_table
    @json = Station.where(
      t[:country].eq("MALAYSIA").
      or(t[:country].eq("VIETNAM")).
      or(t[:country].eq("INDONESIA")).
      or(t[:country].eq("THAILAND"))).to_gmaps4rails
  end

  def all_temps
  end
  
end
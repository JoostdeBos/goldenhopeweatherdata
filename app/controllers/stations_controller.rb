class StationsController < ApplicationController
	before_filter :login_required

  def index
    @stations = Station.order("country", "city").page(params[:page]).per(25)
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
    # data = @station.weatherdata
    # @all_temps = []
    # data.each do |t|
    #   @all_temps << t["temp"].round(2)
    # end
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
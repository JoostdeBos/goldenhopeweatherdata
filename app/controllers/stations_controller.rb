class StationsController < ApplicationController
	before_filter :login_required

  def index
    #if we're searching for something
    if params[:search].present?
      @stations = Station.any_of({:country => params[:search].upcase}, {:city => params[:search].upcase}).page(params[:page]).per(25)
    else
      #if we are not searching show all
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
        @all_temps << m.temp.round(2)
        @all_clouds << m.cloudcoverage.round(2)
      end
  end


  def all_to_xml
  @stations = Station.all.limit(250)
  send_data @stations.to_xml,
    :type => 'text/xml; charset=UTF-8;',
    :disposition => "attachment; filename=stations.xml"
  end

  def map
    @json = Station.all.limit(100).to_a.to_gmaps4rails do |station, marker| 
      marker.json "\"id\": \"#{station.id}\""
    end
  end

  def load_chart
    @station = Station.find(params[:station_id]) 
    @measurement = @station.measurements.last
    @all_clouds = []
    #build graph data
    @station.measurements.order(:desc).limit(15).each do |m|
      @all_clouds << m.cloudcoverage
    end
    @all_clouds.reverse
  end
  
end

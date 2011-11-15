class StationsController < ApplicationController
	before_filter :login_required
      
  def index
    #if we're searching for something
    if params[:search].present?
      @stations = Station.any_of({:country => params[:search].upcase}, {:city => params[:search].upcase}).asc(:address).page(params[:page]).per(25)
    else
      #if we are not searching show all
      @stations = Station.all.asc(:address).page(params[:page]).per(25)
    end
  end

  def show
  	@station = Station.find(params[:id])
    @datasetthree = @station.datasetthrees
    @datasets = [@station.datasetones, @station.datasettwos]
    @all_temps = []
    @all_clouds = []
    #build graph data
      @station.datasetones.each do |m|
        @all_temps << m.temp.round(2)
        @all_clouds << m.cldc.round(2)
      end
  end


  def all_to_xml
  @stations = Station.all.limit(250)
  send_data @stations.to_xml,
    :type => 'text/xml; charset=UTF-8;',
    :disposition => "attachment; filename=stations.xml"
  end

  def map
    @json = Station.all.limit(4000).to_a.to_gmaps4rails do |station, marker| 
      marker.json "\"id\": \"#{station.id}\""
    end
  end

  def load_chart

    @station = Station.find(params[:station_id]) 
    @measurement = @station.datasetones.last
    @all_clouds = []
    @all_dates = []
    #build graph data
    @station.datasetones.order(:desc).limit(15).each do |m|
      @all_clouds << m.cloudcoverage
      @all_dates << m.date.to_i
    end
    @all_clouds.reverse
    @all_dates.reverse
  end
  
end

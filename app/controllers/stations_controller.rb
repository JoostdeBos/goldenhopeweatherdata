class StationsController < ApplicationController
	before_filter :login_required
  MIN_PRECIPITATION = 5
  MAX_PRECIPITATION = 10
  MIN_TEMP = 20
  MAX_TEMP = 30

  def index
    if params[:search].present?
      #this isn't really DRY yet, need to fix but not smart enough
      if params[:distance].present?
         @stations = Station.near(params[:search], params[:distance], :units => :km, :order => :distance).page(params[:page]).per(25)
       else
        @stations = Station.near(params[:search], 50, :units => :km, :order => :distance).page(params[:page]).per(25)
      end
    else
      @stations = Station.all.page(params[:page]).per(25)
    end
  end

  def dataset1
    #gets average temperature of all measurements where temperature was in range
    #we probably need to do the actual query with map/reduce but map/reduce is hard :(
    @dataset1 = Kaminari.paginate_array(Weatherdata.collection.group([:station_id],
                                            {:temp => {:$gte => MIN_TEMP, :$lt => MAX_TEMP}}, {:temperature => 0, :count => 0, :max_temp => 0, :precipitation => 0},
                                            "function(doc, prev) {
                                              prev.temperature += doc.temp, 
                                              prev.precipitation += doc.precipitation,
                                              prev.count += 1, 
                                              prev.max_temp < doc.temp ? prev.max_temp = doc.temp : prev.max_temp = prev.max_temp}", 
                                            "function(prev) {
                                              prev.average = prev.temperature / prev.count,
                                              prev.average_pre = prev.precipitation / prev.count}")).page(params[:page]).per(25)
  end

  def show
  	@station = Station.find(params[:id])
    @measurement = @station.measurements.last
    @all_temps = []
    @all_clouds = []
      @station.measurements.each do |m|
      @all_temps.push m.temp
      @all_clouds.push m.cloudcoverage
    end
  end

  def map
    @json = Station.all.to_a.to_gmaps4rails
  end
  
end
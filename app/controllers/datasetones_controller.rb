class DatasetonesController < ApplicationController
	before_filter :login_required

	def index
    #if we're searching for something
    if params[:search].present?
      #if we're searching with a distance, use that
      if params[:distance].present?
         @stations = Station.dataset_one.near(params[:search], params[:distance], :units => :km, :order => :distance).page(params[:page]).per(25)
        #otherwise, search within 50km
      else
        @stations = Station.dataset_one.near(params[:search], 50, :units => :km, :order => :distance).page(params[:page]).per(25)
      end
    #when there are no search params show all (paged at 25 stations per page)
    else
      @stations = Station.dataset_one.all.page(params[:page]).per(25)
    end
  end

  def show
  	@station = Station.find(params[:id])
    @measurement = @station.datasetones.last
    @all_temps = []
    @all_prcp = []
    #build graph data
      @station.datasetones.each do |dataset|
        @all_temps << dataset.temp.round(2)
        @all_prcp << dataset.prcp.round(2)
      end
  end

end

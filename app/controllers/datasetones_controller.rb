class DatasetonesController < ApplicationController
	before_filter :login_required

	def index
    #if we're searching for something
    if params[:date].present?
      if params[:search].present?
        @stations = Station.dataset_one.any_of({:country => params[:search].upcase}, {:city => params[:search].upcase}, {:datasetone.date => params[:date]}).page(params[:page]).per(25)
      else
        #if we are not searching show all
        @stations = Station.dataset_one.any_of({:datasetone.date => params[:date]}).page(params[:page]).per(25)
      end
    elsif params[:search].present?
      @stations = Station.dataset_one.any_of({:country => params[:search].upcase}, {:city => params[:search].upcase}).page(params[:page]).per(25)
    else
      @stations = Station.dataset_one.any_of({:datasetones.last.date => Date.now}).page(params[:page]).per(25)
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

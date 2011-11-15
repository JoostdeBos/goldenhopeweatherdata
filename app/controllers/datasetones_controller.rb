class DatasetonesController < ApplicationController
	before_filter :login_required

	def index
    if params[:date].present?
      if params[:search].present?
        @stations = Station.dataset_one_on_date(params[:date].to_time + 1.day).any_of({:country => params[:search].upcase}, {:city => params[:search].upcase}).page(params[:page]).per(25)
      else
        @stations = Station.dataset_one_on_date(params[:date].to_time + 1.day).page(params[:page]).per(25)
      end
    elsif params[:search].present?
      @stations = Station.dataset_one_on_date(Time.now).any_of({:country => params[:search].upcase}, {:city => params[:search].upcase}).page(params[:page]).per(25)
    else
      @stations = Station.dataset_one_on_date(Time.now).page(params[:page]).per(25)
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

  #this should be a lot cleaner, the without method should be invoked somewhere in the scope but hackedyhack before deadlines
  def datasetone_to_xml
    if params[:date].present?
      date = params[:date]
      if params[:search].present?
        @stations = Station.dataset_one_on_date(params[:date].to_time + 1.day).any_of({:country => params[:search].upcase}, {:city => params[:search].upcase}).without(:datasettwos, :datasetthrees)
      else
        @stations = Station.dataset_one_on_date(params[:date].to_time + 1.day)without(:datasettwos, :datasetthrees)
      end
    elsif params[:search].present?
      date = Time.now
      @stations = Station.dataset_one_on_date(Time.now).any_of({:country => params[:search].upcase}, {:city => params[:search].upcase}).without(:datasettwos, :datasetthrees)
    else
      date = Time.now
      @stations = Station.dataset_one_on_date(Time.now).page(params[:page]).without(:datasettwos, :datasetthrees)
    end
    send_data @stations.to_xml,
    :type => 'text/xml; charset=UTF-8;',
    :disposition => "attachment; filename=datasetone #{date}.xml"
  end

end

class DatasetonesController < ApplicationController
	before_filter :login_required

	def index
    if params[:date].present?
      if params[:search].present?
        stations = Station.dataset_one_on_date(params[:date].to_time + 1.day).any_of({:country => params[:search].upcase}, {:city => params[:search].upcase})
      else
        stations = Station.dataset_one_on_date(params[:date].to_time + 1.day)
      end
    elsif params[:search].present?
      stations = Station.dataset_one_on_date(Time.now).any_of({:country => params[:search].upcase}, {:city => params[:search].upcase})
    else
      stations = Station.dataset_one_on_date(Time.now)
    end
    @stations = stations.page(params[:page]).per(25)
  end

  def show
  	@station = Station.find(params[:id])
    @measurements = @station.datasetones
    @all_temps = []
    @all_prcp = []
    #build graph data
      @station.datasetones.each do |dataset|
        @all_temps << dataset.temp.round(2)
        @all_prcp << dataset.prcp.round(2)
      end
  end

  #creates a downloadable xml file of al the stations that have a dataset one on the selected date
  #if no date argument is given in the search it defaults to todays datasets
  def datasetone_to_xml
    if params[:date].present?
      date = params[:date]
      if params[:search].present?
        datasetone = Station.dataset_one_on_date(params[:date].to_time + 1.day).any_of({:country => params[:search].upcase}, {:city => params[:search].upcase})
      else
        datasetone = Station.dataset_one_on_date(params[:date].to_time + 1.day)
      end
    elsif params[:search].present?
      date = Date.today
      datasetone = Station.dataset_one_on_date(Time.now).any_of({:country => params[:search].upcase}, {:city => params[:search].upcase})
    else
      date = Date.today
      datasetone = Station.dataset_one_on_date(Time.now).page(params[:page])
    end
    send_data datasetone.without(:datasettwos, :datasetthrees).to_xml,
    :type => 'text/xml; charset=UTF-8;',
    :disposition => "attachment; filename= iWeather Dataset one #{date}.xml"
  end

end

class DatasettwosController < ApplicationController
	before_filter :login_required

	def index
    if params[:date].present?
      if params[:search].present?
        stations = Station.dataset_two_on_date(params[:date].to_time + 1.day).any_of({:country => params[:search].upcase}, {:city => params[:search].upcase})
      else
        stations = Station.dataset_two_on_date(params[:date].to_time + 1.day)
      end
    elsif params[:search].present?
      stations = Station.dataset_two_on_date(Time.now).any_of({:country => params[:search].upcase}, {:city => params[:search].upcase})
    else
      stations = Station.dataset_two_on_date(Time.now)
    end
    @stations = stations.page(params[:page]).per(25)
  end

  def show
  	@station = Station.find(params[:id])
    @measurements = @station.datasettwos
    @all_temps = []
    @all_prcp = []
    #build graph data
      @station.datasettwos.all.desc().limit(4).each do |dataset|
        @all_temps << dataset.temp.round(2)
        @all_prcp << dataset.prcp.round(2)
      end
  end

  def datasettwo_to_xml
    if params[:date].present?
      date = params[:date]
      if params[:search].present?
        dataset = Station.dataset_two_on_date(params[:date].to_time).any_of({:country => params[:search].upcase}, {:city => params[:search].upcase})
      else
        dataset = Station.dataset_two_on_date(params[:date].to_time)
      end
    elsif params[:search].present?
      date = Date.today
      dataset = Station.dataset_two_on_date(Time.now).any_of({:country => params[:search].upcase}, {:city => params[:search].upcase})
    else
      date = Date.today
      dataset = Station.dataset_two_on_date(Time.now)
    end
    send_data dataset.without(:datasetones, :datasetthrees).to_xml,
    :type => 'text/xml; charset=UTF-8;',
    :disposition => "attachment; filename=iWeather Dataset Two #{date}.xml"
  end

end

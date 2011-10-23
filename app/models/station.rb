class Station < ActiveRecord::Base
  attr_accessible :id, :address, :city, :country, :latitude, :longitude, :elevation, :gmaps
  acts_as_gmappable

  def weatherdata
    ActiveSupport::JSON.decode(Weatherdata.all(:conditions => {:station_id => self.id}).to_json)
  end

  def gmaps4rails_address
    address
  end

  #Maybe we should move this to a partial
  #I don't think you're supposed to have view data in your model but the docs suggest this is the way to go
  def gmaps4rails_infowindow
  	title = "<h5>#{city.capitalize}, #{country.capitalize}<h5>"
    temp = " <p><b>Temperature: </b>#{weatherdata.last["temp"].round(2)}</p>" 
    clouds = "<p> <b>Cloud coverage: </b>#{weatherdata.last["cloudcoverage"].round(2)}</p>"
    title + temp + clouds
  end

  def gmaps4rails_title
      "#{city.capitalize}, #{country.capitalize}"
  end

end

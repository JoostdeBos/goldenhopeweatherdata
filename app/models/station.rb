class Station < ActiveRecord::Base
  attr_accessible :id, :address, :city, :country, :latitude, :longitude, :elevation, :gmaps
  geocoded_by :address
  acts_as_gmappable

  #returns a json array with weatherdata, not sure how to get an object that we can do anything with aorn
  #should probably figure that out though cus this is kind of a dirty hack
  def weatherdata
    ActiveSupport::JSON.decode(Weatherdata.where(:station_id => self.id).sort(:time).to_json)
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

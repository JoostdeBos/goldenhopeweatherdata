class Station < ActiveRecord::Base
  attr_accessible :id, :address, :city, :country, :latitude, :longitude, :elevation, :gmaps
  acts_as_gmappable

  def gmaps4rails_address
    address
  end

  #Maybe we should move this to a partial
  #I don't think you're supposed to have view data in your model but the docs suggest this is the way to go
  def gmaps4rails_infowindow
  	#some dummy data
  	"<h5>#{city.capitalize!}, #{country.capitalize!}<h5> <p><b>Temperature: </b>27</p><p> <b>Cloud density: </b>12</p>"
  end

  def gmaps4rails_title
      "#{city}, #{country}"
  end

end

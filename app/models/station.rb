class Station
  include Gmaps4rails::ActsAsGmappable
  include Mongoid::Document
  include Mongoid::Geo
  include Geocoder::Model::Mongoid
  geocoded_by :address               # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  acts_as_gmappable

  field :id, :type => Integer
  field :address, :type => String
  field :city, :type => String
  field :country, :type => String
  field :latitude, :type => Float
  field :longitude, :type => Float
  field :elevation, :type => Float
  field :gmaps, :type => Boolean
  field :location, :type => Array, :geo => true, :lat => :latitude, :lng => :longitude
  field :coordinates, :type => Array, :lat => :latitude, :lng => :longitude
  embeds_many :measurements
  index(
    [
      [ :id, Mongo::ASCENDING ],
      [ :address, Mongo::ASCENDING ],
      [ :gmaps, Mongo::ASCENDING ]
    ]
  )

  attr_accessible :id, :address, :city, :country, :latitude, :longitude, :elevation, :gmaps

  
  geo_index :location
  

  #returns a json array with weatherdata, not sure how to get an object that we can do anything with aorn
  #should probably figure that out though cus this is kind of a dirty hack
  # def weatherdata
  #   Weatherdata.where(:station_id => self.id).sort(:time)
  # end

  def gmaps4rails_address
    address
  end

  #Maybe we should move this to a partial
  #I don't think you're supposed to have view data in your model but the docs suggest this is the way to go
  def gmaps4rails_infowindow
  	title = "<h5>#{city.capitalize}, #{country.capitalize}<h5>"
    # temp = " <p><b>Temperature: </b>#{weatherdata.temp.round(2)}</p>" 
    # clouds = "<p> <b>Cloud coverage: </b>#{weatherdata.last.cloudcoverage.round(2)}</p>"
    # title + temp + clouds
  end

  def gmaps4rails_title
      "#{city.capitalize}, #{country.capitalize}"
  end

end

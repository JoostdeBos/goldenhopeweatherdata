class Station
  include Gmaps4rails::ActsAsGmappable
  include Mongoid::Document
  include Mongoid::Geo
  include Geocoder::Model::Mongoid

  geocoded_by :address               # can also be an IP address
  after_validation :geocode          # geocoder wants this but we already have all coordinates
  acts_as_gmappable

  field :id,          :type => Integer
  field :address,     :type => String
  field :city,        :type => String
  field :country,     :type => String
  field :latitude,    :type => Float
  field :longitude,   :type => Float
  field :elevation,   :type => Float
  field :gmaps,       :type => Boolean
  field :location,    :type => Array, :geo => true, :lat => :latitude, :lng => :longitude
  field :coordinates, :type => Array, :lat => :latitude, :lng => :longitude
  has_many :measurements
  embeds_many :datasetones
  index(
    [
      [ :id, Mongo::ASCENDING ],
      [ :address, Mongo::ASCENDING ],
      [ :gmaps, Mongo::ASCENDING ]
    ]
  )

  scope :dataset_one, where(:datasetones.exists => true)

  attr_accessible :id, :address, :city, :country, :latitude, :longitude, :elevation, :gmaps

  
  geo_index :location

  def gmaps4rails_address
    address
  end

  #Maybe we should move this to a partial
  #I don't think you're supposed to have view data in your model but the docs suggest this is the way to go
  def gmaps4rails_infowindow
  	title = "<h5>#{city.capitalize}, #{country.capitalize}<h5>"
    if measurements.length > 0
      temp = " <p><b>Temperature: </b>#{measurements.last.temp.round(1)}&deg;</p>" 
      clouds = "<p> <b>Cloud coverage: </b>#{measurements.last.cloudcoverage.round(1)}%</p>"
      js = "onClick=getChart('#{id}');"
      link = "<a href='#' id='#{id}' #{js}>Show chart</a>"
      title + temp + clouds + link
    else
      title + "<p>No data available</p>"
    end
  end

  def gmaps4rails_title
      "#{city.capitalize}, #{country.capitalize}"
  end

end

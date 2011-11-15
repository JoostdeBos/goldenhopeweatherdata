class Station
  include Gmaps4rails::ActsAsGmappable
  include Mongoid::Document
  include Mongoid::Geo
  include Geocoder::Model::Mongoid

  attr_accessible :stn, :address, :city, :country, :latitude, :longitude, :elevation, :gmaps, :location, :coordinates

  geocoded_by :address               # can also be an IP address
  after_validation :geocode          # geocoder wants this but we already have all coordinates
  acts_as_gmappable

  field :stn,         :type => Integer
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
  embeds_many :datasettwos
  index(
    [
      [ :id, Mongo::ASCENDING ],
      [ :address, Mongo::ASCENDING ],
      [ :gmaps, Mongo::ASCENDING ]
    ]
  )

  scope :dataset_one, where(:datasetones.exists => true)

  #scope that filters all stations that have a dataset one on a given date
  #
  #Usage:
  #Station.dataset_one_on_date(Time.now)
  # => fetches all stations that have a datasetone today
  #
  #Station.dataset_one_on_date(Time.parse('2011-11-11'))
  # => fetches all stations that have a dataset on 11-11-11
  #
  scope :dataset_one_on_date, lambda {|date| where("datasetones.date" => {'$gte' => date - 1.day, '$lt' => date }) }
  
  geo_index :location

  def gmaps4rails_address
    address
  end

  #If i delete this it doesn't work..
  #don't judge me
  def gmaps4rails_infowindow
  end

  def gmaps4rails_title
      "#{city.capitalize}, #{country.capitalize}"
  end

end

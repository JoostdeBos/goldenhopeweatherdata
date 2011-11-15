class Measurement
	include Gmaps4rails::ActsAsGmappable
  	include Mongoid::Document
  	include Mongoid::Geo

  	belongs_to :station

	field :date, :type => Date
	field :utime, :type => Time
	field :temp, :type => Float
	field :dewpoint, :type => Float
	field :airpressure, :type => Float
	field :stationpressure, :type => Float
	field :visibility, :type => Float
	field :windspeed, :type => Float
	field :precipitation, :type => Float
	field :snow, :type => Float
	field :cloudcoverage, :type => Float
	field :winddir, :type => Integer

end
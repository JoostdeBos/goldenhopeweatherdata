class Weatherdata
	include MongoMapper::Document

	key :station_id, Integer
	key :date, Date
	key :time, Time
	key :temp, Float
	key :dewpoint, Float
	key :airpressure, Float
	key :stationpressure, Float
	key :visibility, Float
	key :windspeed, Float
	key :precipitation, Float
	key :snow, Float
	key :cloudcoverage, Float
	key :winddir, Integer

end
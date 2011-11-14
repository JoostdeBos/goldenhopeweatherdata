# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
  
require 'csv'

#fill the database with all the stations
# Station.delete_all
CSV.open('/Users/jurrestender/golden_hope/db/stations.csv', 'r', ';').each do |row|
  	station = Station.create!(
		:stn => row[0], 
		:address =>"#{row[1]}, #{row[2]}", 
		:city => row[1], 
		:country => row[2], 
		:latitude => row[3], 
		:longitude => row[4],
		:elevation => row[5],
		:gmaps => true)
end

# for station in Station.all
# 	for i in 1..2
# 		station.measurements << [Measurement.new(
# 			:date => DateTime.now, 
# 			:utime => Time.now, 
# 			:temp => rand * 50, 
# 			:dewpoint => rand * 40, 
# 			:airpressure => rand * 1000,
# 			:stationpressure => rand * 945,
# 			:visibility => rand * 100,
# 			:windspeed => rand * 40,
# 			:precipitation => rand * 20,
# 			:snow => rand * 10,
# 			:cloudcoverage => rand * 75,
# 			:winddir => rand(360))]
<<<<<<< HEAD
# 		station.save
# 	end
# end

# for station in Station.all.limit(250)
# 	for i in 1..7
# 		date = 7.days.ago
# 		days_ago = 0
# 		station.datasetones << [Datasetone.new(
# 			:date => date + days_ago.day, #increment one day each iteration
# 			:temp => rand * 10 + 10, #random between 10 and 20
# 			:dewp => rand * 40, 
# 			:stp => rand * 1000,
# 			:slp => rand * 945,
# 			:visib => rand * 100,
# 			:wdsp => rand * 40,
# 			:prcp => rand * 5 + 5, #random between 5 and 10
# 			:sndp => rand * 20,
# 			:cldc => rand * 10,
# 			:wnddir => rand(360))]
=======
>>>>>>> 823088733f49fb7f5f9b464fa8c914b26a97861c
# 		station.save
# 	end
# end

for station in Station.all.limit(250)
	for i in 1..7
		date = 7.days.ago
		days_ago = 0
		station.datasetones << [Datasetone.new(
			:date => date + days_ago.day, #increment one day each iteration
			:temp => rand * 10 + 10, #random between 10 and 20
			:dewp => rand * 40, 
			:stp => rand * 1000,
			:slp => rand * 945,
			:visib => rand * 100,
			:wdsp => rand * 40,
			:prcp => rand * 5 + 5, #random between 5 and 10
			:sndp => rand * 20,
			:cldc => rand * 10,
			:wnddir => rand(360))]
		station.save

		days =+ 1
	end
end

		
#create an admin user, uncomment when running for the first time
# User.create!(:username => 'admin', :password => 'admin', :confirm_password => 'admin', :email => 'admin@goldenhope.com')

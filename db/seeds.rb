# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
  
require 'csv'

#fill the database with all the stations
Station.delete_all
CSV.open('/Users/jurrestender/golden_hope/db/stations.csv', 'r', ';').each do |row|
  Station.create!(:id => row[0], :address =>"#{row[1]}, #{row[2]}", :city => row[1], :country => row[2], :latitude => row[3], :longitude => row[4], :gmaps => true, :elevation => row[5])
  #create some data for the stations
  for i in (1..20)
	  data = Weatherdata.new(	:station_id => row[0], 
	  					:date => DateTime.now, 
	  					:time => Time.now, 
	  					:temp => rand * 50, 
	  					:dewpoint => rand * 40, 
	  					:airpressure => rand * 1000,
	  					:stationpressure => rand * 945,
	  					:visibility => rand * 100,
	  					:windspeed => rand * 40,
	  					:precipitation => rand * 20,
	  					:snow => rand * 10,
	  					:cloudcoverage => rand * 75,
	  					:winddir => rand(360)
	  					)
	  data.save!
	end
end

#create an admin user, uncomment when running for the first time
# User.create!(:username => 'admin', :password => 'admin', :confirm_password => 'admin', :email => 'admin@goldenhope.com')

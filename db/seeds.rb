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
end
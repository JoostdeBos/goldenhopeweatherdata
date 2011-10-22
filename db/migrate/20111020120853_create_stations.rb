class CreateStations < ActiveRecord::Migration
  def self.up
    create_table :stations do |t|
      t.integer :id
      t.string :address
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude
      t.integer :elevation
      t.boolean :gmaps
      t.timestamps
    end
  end

  def self.down
    drop_table :stations
  end
end

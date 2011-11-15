class Datasetone
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  embedded_in :station, :inverse_of => :datasetones

  field :stn, 		:type => Integer
  field :date, 		:type => Time
  field :temp, 		:type => Float
  field :dewp, 		:type => Float
  field :stp, 		:type => Float
  field :slp, 		:type => Float
  field :visib, 	:type => Float
  field :wdsp, 		:type => Float
  field :prcp, 		:type => Float
  field :sndp, 		:type => Float
  field :cldc, 		:type => Float
  field :wnddir, 	:type => Float


end

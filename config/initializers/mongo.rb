# mongo_cfg = YAML.load(IO.read("#{RAILS_ROOT}/config/mongodb.yml"))[RAILS_ENV]

# args = [mongo_cfg['host'], mongo_cfg['port']].compactMongoMapper.connection = Mongo::Connection.new(*conn_args)


# db_cfg = Rails.configuration.database_configuration[RAILS_ENV]MongoMapper.database = mongo_cfg['database'] || db_cfg['database']

MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "#myapp-#{Rails.env}"

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect if forked
   end
end
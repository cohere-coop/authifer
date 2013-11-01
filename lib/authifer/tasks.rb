namespace :authifer do
  namespace :db do
    desc "Migrate up the database"
    task :migrate do
      require_relative 'schema'
      Authifer::Schema.migrate
    end
  end
end

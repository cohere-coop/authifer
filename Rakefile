require './auth_makeheadspace_app'
require 'sinatra/activerecord/rake'

namespace :db do
  task :seed do
    require './db/seeds'
    Seeder.seed
  end
end

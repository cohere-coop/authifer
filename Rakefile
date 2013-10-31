require './auth_makeheadspace_app'
require 'sinatra/activerecord/rake'

namespace :db do
  namespace :oauth2 do
    desc "migrate oauth2 schema"
    task :migrate do
      Songkick::OAuth2::Model::Schema.migrate
    end
  end
  task :seed do
    require './db/seeds'
    Seeder.seed
  end
end

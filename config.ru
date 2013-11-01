require './initialiers/dotenv'
require './lib/authifer'
require './auth_makeheadspace_app'
Authifer.database_url=ENV['DATABASE_URL']

use Authifer::App
run Sinatra::Application

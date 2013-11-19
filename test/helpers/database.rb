require './test/helpers/default'
require './test/helpers/dotenv'

require './lib/authifer'

Authifer.configure do |config|
  config.database_url = ENV['DATABASE_URL']
end
Authifer::Schema.migrate

class DatabaseTest < Minitest::Test
  def setup
    Authifer::User.destroy_all
  end
end

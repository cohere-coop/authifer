require './test/helpers/default'
require './test/helpers/dotenv'

require './lib/authifer'

Authifer.connect_to_database(ENV['DATABASE_URL'])
Authifer::Schema.migrate

class DatabaseTest < Minitest::Test
  def setup
    Authifer::User.destroy_all
  end
end

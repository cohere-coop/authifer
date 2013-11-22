require './test/helpers/default'
require './test/helpers/dotenv'
require './lib/authifer'
require './test/helpers/user'


Authifer.configure do |config|
  config.database_url = ENV['DATABASE_URL']
  config.user_model = Test::User
end

Authifer::Schema.migrate

class DatabaseTest < Minitest::Test
  User = Test::User
  def setup
    User.destroy_all
  end
end

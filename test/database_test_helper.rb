require './test/test_helper'
require 'active_record'
require './initializers/dotenv'
require './lib/authifer'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
Authifer::Schema.migrate


class DatabaseTest < Minitest::Test
  def setup
    Authifer::User.destroy_all
  end
end

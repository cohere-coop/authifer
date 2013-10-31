require './test/test_helper'
require 'active_record'
require './initializers/dotenv'


ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
ActiveRecord::Migrator.up('db/migrate')

require 'songkick/oauth2/provider'
Songkick::OAuth2::Model::Schema.migrate

class DatabaseTest < Minitest::Test
  def setup
    User.destroy_all
  end
end

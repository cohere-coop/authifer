require './test/test_helper'
require 'active_record'

ActiveRecord::Base.establish_connection('postgres://localhost/auth_makeheadspace_test')
ActiveRecord::Base.logger = Logger.new('/dev/null')
ActiveRecord::Migrator.up('db/migrate')

require 'songkick/oauth2/provider'
Songkick::OAuth2::Model::Schema.migrate

class DatabaseTest < Minitest::Test
  def setup
    super
    User.destroy_all
  end
end

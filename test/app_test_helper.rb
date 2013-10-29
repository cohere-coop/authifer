require './test/test_helper'
require './test/database_test_helper'
require 'capybara'
require './auth_makeheadspace_app'

Capybara.app = Sinatra::Application

class AppTest < MiniTest::Test
  include Capybara::DSL

  def setup
    User.destroy_all
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end


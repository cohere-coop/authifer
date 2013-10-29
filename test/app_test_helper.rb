require './test/test_helper'
require './test/database_test_helper'
require 'capybara'
require './auth_makeheadspace_app'

Capybara.app = Sinatra::Application


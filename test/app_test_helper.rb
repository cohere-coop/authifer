require './test/test_helper'
require './test/database_test_helper'
require 'capybara'
require './auth_makeheadspace_app'

Capybara.app = Authifer::App

class AppTest < MiniTest::Test
  include Capybara::DSL

  def login(user_attributes)
    visit "/"
    within "#login_form" do
      fill_in "user[email]", with: user_attributes.fetch(:email, "")
      fill_in "user[password]", with: user_attributes.fetch(:password, "")
      click_on "Log in"
    end
  end

  def setup
    User.destroy_all
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end


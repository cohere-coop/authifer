require './test/app_test_helper'

class TestRegistering < MiniTest::Test

  include Capybara::DSL

  def setup
    User.destroy_all
  end

  def register(user_attributes)
    visit '/'
    within "#registration_form" do
      fill_in "user[email]", with: user_attributes.fetch(:email, "")
      fill_in "user[password]", with: user_attributes.fetch(:password, "")
      fill_in "user[password_confirmation]", with: user_attributes.fetch(:password_confirmation, "")
      click_on "Register"
    end
  end

  def test_registering

    register(email: "test@example.com",
             password: "password",
             password_confirmation: "password")
    new_user = User.last
    assert new_user.email == "test@example.com"
    assert new_user.password == "password"
  end

  def test_registering_without_a_password
    register(email: "test@example.com")
    assert page.has_content?("Password can't be blank")
    assert User.all.empty?
  end
end

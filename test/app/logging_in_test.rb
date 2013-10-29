require './test/app_test_helper'

class TestLoggingIn < AppTest

  def login(user_attributes)
    visit "/"
    within "#login_form" do
      fill_in "user[email]", with: user_attributes.fetch(:email, "")
      fill_in "user[password]", with: user_attributes.fetch(:password, "")
      click_on "Log in"
    end
  end

  def test_logging_in
    user_attributes = { email: "foo@example.com", password: "password"}
    user = User.create(user_attributes)

    login(user_attributes)

    assert page.has_content? "Logged in as: foo@example.com"
  end

  def test_prevents_invalid_credentials
    user_attributes = { email: "invalid@example.com", password: "foo" }

    login(user_attributes)

    assert page.has_content? "Credentials are invalid"
  end
end

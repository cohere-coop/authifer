require './test/app_test_helper'

class TestLoggingIn < AppTest
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


  def test_logging_out
    user_attributes = { email: "foo@example.com", password: "password"}
    user = User.create(user_attributes)

    login(user_attributes)
    visit '/sessions/delete'

    assert page.has_no_content? "Logged in as: foo@example.com"
  end
end

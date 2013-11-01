require './test/app_test_helper'

class TestRegistering < AppTest

  def test_registering

    register(email: "test@example.com",
             password: "password",
             password_confirmation: "password")
    new_user = User.last
    assert page.has_content? "Logged in as: test@example.com"
    assert new_user.email == "test@example.com"
    assert new_user.password == "password"
  end

  def test_registering_without_a_password
    register(email: "test@example.com")
    assert page.has_content?("Password can't be blank")
    assert User.all.empty?
  end
end

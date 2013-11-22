require './test/helpers/default'
require './test/helpers/fake_data_access_layer'
require './lib/authifer/authentication_helper'

class TestSessionsHelper < MiniTest::Test
  include Authifer::AuthenticationHelper
  include FakeDataAccessLayer

  def session
    @session ||= {}
  end

  def test_authenticate_user_with_valid_user
    user_attributes = {
      email: "test@example.com",
      password: "password"
    }

    create_user(user_attributes)

    user = authenticate_user(user_attributes)

    assert user.email == "test@example.com"
    assert user.password == "password"

    assert user.errors.empty?
  end

  def test_authenticate_user_with_invalid_user
    user_attributes = {
      email: "test@example.com",
      password: "password"
    }

    user = authenticate_user(user_attributes)

    refute user.errors[:credentials].empty?
    refute user.errors.empty?
  end

  def test_authenticate_user_with_valid_auth_token
    user_attributes = {
      email: "test@example.com",
      password: "password"
    }

    user = create_user(user_attributes)

    user.auth_tokens.push("foo")

    user_attributes[:password] = "foo"

    user = authenticate_user(user_attributes)
    assert user.errors.empty?
  end

  def test_authenticate_user_with_invalid_auth_token
    user_attributes = {
      email: "test@example.com",
      password: "password"
    }

    user = create_user(user_attributes)
    user.auth_tokens.push("foo")
    user_attributes[:password] = "bar"

    user = authenticate_user(user_attributes)

    refute user.errors.empty?
    refute user.errors[:credentials].empty?
  end

  def test_current_user_after_login
    user = create_user(id: 1)

    login(user)

    assert current_user == user
  end

  def test_current_user_before_login
    refute current_user.persisted?
  end

  def test_login
    user = build_user(id: 1)

    login(user)

    assert logged_in?
  end

  def test_logout
    user = build_user(id: 1)

    login(user)
    logout

    refute logged_in?
  end
end

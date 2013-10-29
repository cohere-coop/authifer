require './test/database_test_helper'
require './models/user'

class TestUser < DatabaseTest

  def test_user_email_must_be_unique
    user_attributes = {
      email: "test@example.com",
      password: "password"
    }
    user1 = User.create(user_attributes)
    assert user1.valid?

    user2 = User.new(user_attributes)

    refute user2.valid?
  end

  def test_user_must_have_password
    user_attributes = {
      email: "test@example.com",
    }

    user = User.create(user_attributes)

    refute user.valid?
  end

  def test_user_password_and_confirmation_must_match
    user_attributes = {
      email: "test@example.com",
      password: "ifoo",
      password_confirmation: "ibar",
    }

    user = User.create(user_attributes)

    refute user.valid?
  end
end

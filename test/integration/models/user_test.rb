require './test/helpers/database'

class TestUser < DatabaseTest

  User = Authifer::User
  def test_user_password_is_encrypted
    user_attributes = {
      email: "test@example.com",
      password: "password"
    }
    user = User.new(user_attributes)

    refute user.password.to_s == "password"
  end

  def test_user_email_must_be_unique
    user_attributes = {
      email: "test@example.com",
      password: "password"
    }
    user1 = User.create(user_attributes)
    assert user1.valid?

    user2 = User.new(user_attributes)

    user2.valid?
    refute user2.errors[:email].empty?
  end

  def test_user_must_have_password
    user_attributes = {
      email: "test@example.com",
    }

    user = User.new(user_attributes)

    user.valid?
    refute user.valid?
    refute user.errors[:password].empty?
  end

  def test_user_password_and_confirmation_must_match
    user_attributes = {
      email: "test@example.com",
      password: "ifoo",
      password_confirmation: "ibar",
    }

    user = User.new(user_attributes)

    refute user.valid?
    refute user.errors[:password_confirmation].empty?
  end
end

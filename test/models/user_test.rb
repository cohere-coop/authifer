require 'active_record'
ActiveRecord::Base.logger = Logger.new('/dev/null')
ActiveRecord::Base.establish_connection(adapter:  'sqlite3', database: ':memory:')
ActiveRecord::Migrator.up('db/migrate')
require './models/user'

class TestUser < Minitest::Test
  def setup
    User.destroy_all
  end

  def test_user_email_must_be_unique
    user_attributes = {
      email: "test@example.com",
      password: "password"
    }
    user1 = User.create(user_attributes)
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

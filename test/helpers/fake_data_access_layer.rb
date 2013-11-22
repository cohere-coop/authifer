require 'ostruct'

module FakeDataAccessLayer
  def create_user(attributes)
    user = build_user(attributes)
    cached_users << user
    user
  end

  def find_user(attributes)
    attribute_key = attributes.has_key?(:id) ? :id : :email
    cached_users.find do |u|
      u.send(attribute_key) == attributes[attribute_key]
    end
  end

  def cached_users
    @cached_users ||= []
  end

  def build_user(attributes={})
    User.new(attributes)
  end

  class User < OpenStruct
    def errors
      super || self.errors = Errors.new
    end

    def auth_tokens
      super || self.auth_tokens = []
    end

    def password
      super
    end
  end

  class Errors < Hash
    def add(field, message)
      self[field] ||= []
      self[field].push(message)
    end
  end
end

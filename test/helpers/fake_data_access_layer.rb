require 'ostruct'

module FakeDataAccessLayer
  def create_user(attributes)
    attribute_key = attributes.has_key?(:id) ? :id : :email
    cached_users[attribute_key] = build_user(attributes)
  end

  def find_user(attributes)
    attribute_key = attributes.has_key?(:id) ? :id : :email
    cached_users[attribute_key]
  end

  def cached_users
    @cached_users ||= {}
  end

  def build_user(attributes={})
    User.new(attributes)
  end

  class User < OpenStruct
    def errors
      super || self.errors = Errors.new
    end
  end

  class Errors < Hash
    def add(field, message)
      self[field] ||= []
      self[field].push(message)
    end
  end
end

require 'protected_attributes'
require 'bcrypt'

module Authifer
  module User

    def self.included(klazz)
      klazz.send(:include, Songkick::OAuth2::Model::ResourceOwner)
      klazz.send(:include, Songkick::OAuth2::Model::ClientOwner)

      klazz.validates :password, confirmation: true
      klazz.validate :password_is_set
      klazz.validates :email, uniqueness: true
      klazz.serialize :auth_tokens
    end

    def password=password
      @password = BCrypt::Password.create(password)
      self.password_digest = @password
    end

    def password
      @password ||= BCrypt::Password.new(password_digest) if password_digest
    end

    def password_is_set
      if !password || password == ""
        errors.add(:password, "can't be blank")
      end
    end
  end
end

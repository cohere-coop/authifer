require 'protected_attributes'
require 'bcrypt'

class User < ActiveRecord::Base
  include Songkick::OAuth2::Model::ResourceOwner
  include Songkick::OAuth2::Model::ClientOwner

  validates :password, confirmation: true
  validate :password_is_set
  validates :email, uniqueness: true

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

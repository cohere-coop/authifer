require 'protected_attributes'

class User < ActiveRecord::Base
  include Songkick::OAuth2::Model::ResourceOwner
  include Songkick::OAuth2::Model::ClientOwner

  validates :password, confirmation: true, presence: true
  validates :email, uniqueness: true
end

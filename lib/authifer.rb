require_relative 'authifer/schema'
require_relative 'authifer/user'
require 'songkick/oauth2/provider'

module Authifer
  def self.database_url= database_url
    @database_url = database_url
  end

  def self.database_url
    raise "You must provide a database url when configuring Authifer" unless @database_url
    @database_url
  end

  def self.views_path=views_path
    @views_path = views_path
  end

  def self.enforce_ssl
    @enforce_ssl.nil? ? true : @enforce_ssl
  end

  def self.enforce_ssl=enforce
    @enforce_ssl = enforce
  end

  def self.views_path
     @views_path ||= File.join(base_path, 'views')
  end

  def self.base_path
    @base_path ||= File.join(File.dirname(File.expand_path(__FILE__)), 'authifer')
  end

  def self.user_model
    raise "You must provide an object which behaves like a User when configuring Authifer" unless @user_model
    @user_model
  end

  def self.user_model=model
    @user_model = model
  end

  def self.configure
    yield(self)

    Songkick::OAuth2::Provider.enforce_ssl = enforce_ssl
    require_relative 'authifer/app'
  end
end

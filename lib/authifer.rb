require_relative 'authifer/schema'

module Authifer
  def self.database_url=database_url
    require_relative 'authifer/app'
    Authifer::App.set :database, database_url
    require_relative 'authifer/user'
    @database_url = database_url
  end

  def self.database_url
    @database_url
  end

  def self.views_path=views_path
    @views_path = views_path
  end

  def self.views_path
     @views_path ||= File.join(base_path, 'views')
  end

  def self.base_path
    @base_path ||= File.join(File.dirname(File.expand_path(__FILE__)), 'authifer')
  end

end

require_relative 'authifer/app'

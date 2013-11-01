require 'sinatra/base'
require 'sinatra/activerecord'
require './initializers/dotenv'
require './initializers/oauth_provider'

Dir['{models,routes,helpers}/**/*.rb'].each do |filename|
  require File.expand_path(filename)
end

module Authifer
  class App < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    set :database, ENV['DATABASE_URL']
    set :views, File.join(File.expand_path('.'), 'views')
    enable :sessions

    helpers do
      include AuthenticationHelper
      include OAuthHelper
      include DataHelper

      def display
        @renderer ||= Renderer.new(self)
      end

      def redirect_url
        @redirect_url ||= params[:redirect_url] || "/"
      end
    end

    get '/' do
      display.home
    end

    post '/users' do
      user = create_user(params[:user])
      complete_login(user, user.persisted?)
    end

  end
end

if $0 == __FILE__
  Authifer::App.run!
end

require 'sinatra/base'
require 'sinatra/activerecord'
require_relative 'authentication_helper'
require_relative 'renderer'
require_relative 'oauth_helper'
require_relative 'data_helper'
require_relative 'paths'

module Authifer
  class App < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    set :views, Authifer.views_path
    set :database, Authifer.database_url

    enable :sessions
    extend Authifer::Paths

    helpers do
      include Authifer::AuthenticationHelper
      include Authifer::OAuthHelper
      include Authifer::DataHelper
      include Authifer::Paths


      def display
        @renderer ||= Renderer.new(self)
      end

      def redirect_url
        @redirect_url ||= params[:redirect_url] || "/"
      end
    end

    post users_path do
      user = create_user(params[:user])
      if user.persisted?
        login(user)
        redirect redirect_url
      else
        display.register(user)
      end
    end

    get new_user_path do
      display.register(build_user)
    end

    post sessions_path do
      user = authenticate_user(params[:user])
      if user.errors.empty?
        login(user)
        redirect redirect_url
      else
        display.login(user)
      end
    end

    get new_session_path do
      display.login(build_user)
    end

    [{ method: :get, path: delete_session_path},
     { method: :delete, path: sessions_path    }].each do |route|
      __send__(route[:method], route[:path]) do
        logout
        display.login(build_user)
      end
    end

    before "/oauth/authorize" do
      ensure_logged_in!
    end

    [:get, :post].each do |method|
      __send__(method, '/oauth/token') { handle_oauth }
      __send__(method, '/oauth/authorize') { handle_oauth }
    end

    post '/oauth/allow' do
      @auth = Songkick::OAuth2::Provider::Authorization.new(current_user, params)
      @auth.grant_access!
      redirect @auth.redirect_uri, @auth.response_status
    end
  end
end

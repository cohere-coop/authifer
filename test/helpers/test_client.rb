require 'sinatra/base'
require 'oauth2'
require './test/helpers/dotenv'
require 'authifer'


class TestClient < Sinatra::Base
  PORT = 5001
  CLIENT_SECRET = "a-am-a-secret-hush-hush"
  CLIENT_ID = "i-am-a-client"
  SITE_ROOT = "http://localhost:#{PORT}"
  REDIRECT_PATH = "/oauth2/callback"
  REDIRECT_URL = SITE_ROOT + REDIRECT_PATH

  def self.prime_database
    user = Authifer::User.find_or_create_by(email: "zee@example.com") { |u| u.password = "password" }
    user.save

    client = user.oauth2_clients.find_or_create_by({
      redirect_uri: "#{SITE_ROOT}/oauth2/callback"
    }) do |client|
      client.name = "Development Test App"
    end
    client.client_secret = CLIENT_SECRET
    client.client_id = CLIENT_ID
    client.save
  end

  Authifer.connect_to_database(ENV['DATABASE_URL'])
  use Authifer::App

  def client
    @client ||= OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, :site => "#{SITE_ROOT}")
  end
  get '/' do
    auth_url = client.auth_code.authorize_url(:redirect_uri => "#{REDIRECT_URL}")

    "<a href='#{auth_url}'>Log in</a>"
  end

  get REDIRECT_PATH do
    token = client.auth_code.get_token(params[:code], redirect_uri: "#{REDIRECT_URL}")

    "Here's yer token: #{token.token}"
  end
end

if __FILE__ == $0
  TestClient.prime_database
  TestClient.run!
end

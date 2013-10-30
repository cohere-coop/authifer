require 'sinatra'
require 'oauth2'
require './initializers/dotenv'

get '/' do

  client = OAuth2::Client.new(ENV['TEST_CLIENT_ID'], ENV['TEST_CLIENT_SECRET'], :site => "http://localhost:#{ENV['APP_PORT']}")

  auth_url = client.auth_code.authorize_url(:redirect_uri => 'http://localhost:5001/oauth2/callback')

  "<a href='#{auth_url}'>Log in</a>"
end

get '/oauth2/callback' do
  client = OAuth2::Client.new(ENV['TEST_CLIENT_ID'], ENV['TEST_CLIENT_SECRET'], :site => "http://localhost:#{ENV['APP_PORT']}")
  token = client.auth_code.get_token(params[:code], redirect_uri: "http://localhost:5001/oauth2/callback")
  token.to_s
end

require 'sinatra'
require './initializers/dotenv'
require './initializers/database'
require './initializers/oauth_provider'

Dir['{models,routes,helpers}/**/*.rb'].each do |filename|
  require File.expand_path(filename)
end

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

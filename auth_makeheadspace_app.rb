require 'sinatra'
require 'sinatra/activerecord'
require 'songkick/oauth2/provider'
Songkick::OAuth2::Provider.realm = 'auth.makeheadspace.com - Dev'
require './models/user'

helpers do
  def create_user(user_attributes)
    User.create(user_attributes)
  end
end

get '/' do
  erb :home, locals: { user: User.new }
end

post '/users' do
  user = create_user(params[:user])
  erb :home, locals: { user: user }
end

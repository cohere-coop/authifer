require 'sinatra'
begin
require 'dotenv'
Dotenv.load
rescue LoadError
end
require 'sinatra/activerecord'
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

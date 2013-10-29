require 'sinatra'
require './initializers/dotenv'
require 'sinatra/activerecord'
require 'songkick/oauth2/provider'
Songkick::OAuth2::Provider.realm = 'auth.makeheadspace.com - Dev'
require './models/user'

helpers do
  def create_user(user_attributes)
    User.create(user_attributes)
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def current_user
    @user ||= User.find(session[:user_id])
  end

  def home_template
    logged_in? ? :home : :guest_home
  end
end

get '/' do
  erb home_template, locals: { user: User.new }
end

post '/users' do
  user = create_user(params[:user])
  login(user) if user.persisted?

  erb home_template, locals: { user: user }
end

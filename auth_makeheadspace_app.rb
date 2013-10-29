require 'sinatra'
require './initializers/dotenv'

require 'sinatra/activerecord'
set :database, ENV['DATABASE_URL']

require 'songkick/oauth2/provider'
Songkick::OAuth2::Provider.realm = 'auth.makeheadspace.com - Dev'


require './models/user'
require './helpers/sessions_helper'

enable :sessions


helpers do
  include SessionsHelper

  def navigation_partial
    erb (logged_in? ? :_logged_in_nav : :_logged_out_nav)
  end

  def create_user(user_attributes)
    User.create(user_attributes)
  end

  def current_user
    @user ||= User.find(session[:user_id]) if logged_in?
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
  login(user) && redirect('/') && return if user.persisted?
  erb home_template, locals: { user: user }
end

post '/sessions' do
  user = authenticate_user(params[:user])
  if user.errors.empty?
    login(user)
    redirect '/'
  else
    erb home_template, locals: { user: user }
  end
end

get '/sessions/delete' do
  logout
  redirect '/'
end

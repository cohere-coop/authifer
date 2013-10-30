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

  def login_guest(user)
    @current_user = user
  end

  def complete_login(user, registered)
    if registered
      login(user)
      redirect('/')
    else
      login_guest(user)
      erb home_template
    end
  end

  def home_template
    logged_in? ? :home : :guest_home
  end
end

get '/' do
  erb home_template
end

post '/users' do
  user = create_user(params[:user])
  complete_login(user, user.persisted?)
end

post '/sessions' do
  user = authenticate_user(params[:user])
  complete_login(user, user.errors.empty?)
end

get '/sessions/delete' do
  logout
  redirect '/'
end

[:get, :post].each do |method|
  def handle_oauth

    owner = current_user.persisted? ? current_user : :implicit
    oauth2 = Songkick::OAuth2::Provider.parse(owner, env)

    if oauth2.redirect?
      redirect oauth2.redirect_uri, oauth2.response_status
    end

    headers oauth2.response_headers
    status  oauth2.response_status

    if body = oauth2.response_body
      body
    elsif oauth2.valid?
      erb :authorize, locals: { authorization_request: oauth2 }
    else
      raise "Error Will Robinson"
    end
  end
  __send__(method, '/oauth/token') {
    handle_oauth
  }
  __send__(method, '/oauth/authorize') { handle_oauth }
end


post '/oauth/allow' do
  @auth = Songkick::OAuth2::Provider::Authorization.new(current_user, params)
  @auth.grant_access!
  redirect @auth.redirect_uri, @auth.response_status
end

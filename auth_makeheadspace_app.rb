require 'sinatra'
require './initializers/dotenv'

require 'sinatra/activerecord'
set :database, ENV['DATABASE_URL']

require 'songkick/oauth2/provider'
Songkick::OAuth2::Provider.realm = 'auth.makeheadspace.com - Dev'


require './models/user'

enable :sessions


helpers do
  def create_user(user_attributes)
    User.create(user_attributes)
  end

  def authenticate_user(user_attributes)
    user = User.find_by(email: user_attributes[:email])

    if !user
      user = User.new
    end

    if user.password != user_attributes[:password]
      user.errors.add(:credentials, "are invalid. We don't have any users with that email/password combination")
      erb home_template, locals: { user: user }
    else
      login(user)
      redirect '/'
    end
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !session[:user_id].nil?
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
  login(user) if user.persisted?

  erb home_template, locals: { user: user }
end

post '/sessions' do
  authenticate_user(params[:user])
end

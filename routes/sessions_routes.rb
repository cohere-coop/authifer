module Authifer
  class App < Sinatra::Base
    post '/sessions' do
      user = authenticate_user(params[:user])
      complete_login(user, user.errors.empty?)
    end

    get '/sessions/delete' do
      logout
      redirect '/'
    end
  end
end

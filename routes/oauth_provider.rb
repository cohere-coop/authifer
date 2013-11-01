module Authifer
  class App < Sinatra::Base
    before "/oauth/authorize" do
      ensure_logged_in!
    end

    [:get, :post].each do |method|
      __send__(method, '/oauth/token') { handle_oauth }
      __send__(method, '/oauth/authorize') { handle_oauth }
    end

    post '/oauth/allow' do
      @auth = Songkick::OAuth2::Provider::Authorization.new(current_user, params)
      @auth.grant_access!
      redirect @auth.redirect_uri, @auth.response_status
    end
  end
end

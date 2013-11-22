require 'authifer/authenticable'

module Authifer
  module AuthenticationHelper
    def ensure_logged_in!
      unless logged_in?
        @redirect_url = request.fullpath
        halt display.login(build_user)
      end
    end

    def current_user
      @current_user ||= logged_in? ? find_user(id: session[:user_id]) : build_user
    end

    def login(user)
      session[:user_id] = user.id
    end

    def logged_in?
      !session[:user_id].nil?
    end

    def logout
      session[:user_id] = nil
    end

    def authenticate_user(user_attributes)
      user = find_user(email: user_attributes[:email])

      user = build_user if !user

      user = Authenticable.new(user)
      if !user_matches_attributes?(user, user_attributes)
        user.errors.add(:credentials, "are invalid. We don't have any users with that email/password combination")
      end

      user
    end

    private
    def user_matches_attributes?(user, attributes)
        (!attributes[:password].nil? && !attributes[:password].empty? && user.password == attributes[:password]) ||
        (user.has_auth_token? attributes[:password])
    end
  end
end

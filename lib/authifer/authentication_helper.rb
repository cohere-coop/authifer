module Authifer
  module AuthenticationHelper
    def ensure_logged_in!
      unless logged_in?
        @redirect_url = request.fullpath
        halt display.login
      end
    end

    def current_user
      @current_user ||= logged_in? ? find_user(id: session[:user_id]) : nil
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

      if user.password != user_attributes[:password] || user.password.nil?
        user.errors.add(:credentials, "are invalid. We don't have any users with that email/password combination")
      end

      user
    end
  end
end

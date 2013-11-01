module Authifer
  class Renderer
    attr_reader :app

    def initialize(app)
      @app = app
    end

    def login(user)
      if app.logged_in?
        app.redirect app.redirect_url
      else
        app.erb :new_session, locals: { user: user }
      end
    end

    def register(user)
      if app.logged_in?
        app.redirect app.redirect_url
      else
        app.erb :new_user, locals: { user: user }
      end
    end
  end
end

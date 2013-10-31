class Renderer
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def navigation
    app.erb (app.logged_in? ? :_logged_in_nav : :_logged_out_nav)
  end

  def home
    app.erb (app.logged_in? ? :home : :guest_home)
  end
end

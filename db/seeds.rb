module Seeder
  def self.seed
    user = User.find_or_create_by(email: "zee@example.com") { |u| u.password = "password" }
    user.save
    client = user.oauth2_clients.find_or_create_by({
      redirect_uri: "http://localhost:#{ENV['TEST_CLIENT_PORT']}/oauth2/callback"
    }) do |client|
      client.name = "Development Test App"
    end
    client.client_secret = ENV['TEST_CLIENT_SECRET']
    client.client_id = ENV['TEST_CLIENT_ID']
    client.save
  end
end

require './test/helpers/default'
require './test/helpers/fake_data_access_layer'
require './lib/authifer/authenticable'

class TestUser < DatabaseTest
  include FakeDataAccessLayer

  Authenticable = Authifer::Authenticable

  def test_generate_auth_token!
    user = build_user
    authenticable = Authenticable.new(user)
    token = authenticable.generate_auth_token!
    assert authenticable.has_auth_token?(token)
  end
end

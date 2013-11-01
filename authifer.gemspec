Gem::Specification.new do |s|
  s.name         = 'authifer'
  s.version      = '0.0.1'
  s.date         = '2013-11-01'
  s.description  = 'Run your own Authentication provider!'
  s.summary      = s.description
  s.authors      = ['Zee Spencer']
  s.email        = 'zee@zeespencer.com'

  s.files        = Dir['lib/**/*.rb'] + ['README.md', 'LICENSE']
  s.require_path = "lib"

  s.homepage     = 'http://rubygems.org/gems/authifer'
  s.license      = 'MIT'

  s.add_dependency 'sinatra', '~> 1.0'
  s.add_dependency 'sinatra-activerecord', '~> 1.2'
  s.add_dependency 'songkick-oauth2-provider', '~> 0.10'
  s.add_dependency 'bcrypt-ruby'
  s.add_dependency 'protected_attributes'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'oauth2'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-test'
  s.add_development_dependency 'dotenv'
  s.add_development_dependency 'pg'
end

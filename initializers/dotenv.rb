begin
  require 'dotenv'
  Dotenv.load(".env", ".env.#{ENV['RACK_ENV']}")
rescue LoadError

end

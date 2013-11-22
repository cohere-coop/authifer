require 'active_record'
module Test
  class User < ActiveRecord::Base
    include Authifer::User
  end
end


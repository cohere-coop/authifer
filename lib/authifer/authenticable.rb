require 'securerandom'

module Authifer
  class Authenticable < Delegator
    def initialize(delegatee)
      super
      @delegatee = delegatee
    end

    def __getobj__
      @delegatee
    end

    def __setobj__(obj)
      @delegatee = obj
    end

    def generate_auth_token!
      new_token = SecureRandom.uuid
      auth_tokens << new_token
      new_token
    end

    def has_auth_token?(token)
      auth_tokens.include? token
    end

    def auth_tokens
      super || self.auth_tokens = []
    end
  end
end

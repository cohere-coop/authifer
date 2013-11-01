module Authifer
  module DataHelper
    def find_user(attributes)
      User.find_by(attributes)
    end

    def create_user(user_attributes)
      User.create(user_attributes)
    end

    def build_user(attributes={})
      User.new(attributes)
    end
  end
end

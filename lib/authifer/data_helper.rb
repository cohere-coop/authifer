module Authifer
  module DataHelper
    def find_user(attributes)
      Authifer.user_model.find_by(attributes)
    end

    def create_user(user_attributes)
      Authifer.user_model.create(user_attributes)
    end

    def build_user(attributes={})
      Authifer.user_model.new(attributes)
    end
  end
end

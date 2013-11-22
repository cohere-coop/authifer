module Authifer
  module Schema
    def self.migrate
      require 'songkick/oauth2/provider'
      Songkick::OAuth2::Model::Schema.migrate
      ActiveRecord::Migrator.up(File.join(Authifer.base_path,'schema'))
    end

    def self.rollback
      ActiveRecord::Migrator.down(File.join(Authifer.base_path,'schema'))
    end
  end
end

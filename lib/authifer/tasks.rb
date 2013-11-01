
namespace :authifer do
  namespace :db do
    task :migrate do
      require_relative 'schema'
      Authifer::Schema.migrate
    end
  end
end

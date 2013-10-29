Dir['./test/{unit,integration}/**/*_test.rb'].each do |test|
  require File.expand_path(test)
end

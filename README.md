# Authifer

`Trust me Authifer, I'm not half as think as you drunk I am!`

One obstacles to chiseling away a monolithic application architecture is
managing user authentication on several smaller apps.

Authifer abstracts authentication into it's own application so you can focus
your attention on adding useful features for your customers instead of managing
user identities.

## Usage


```ruby
require 'sinatra'

Authifer.connect_to_database('sqlite3://db/auth_provder.sqlite3')

use Authifer::App

helpers do
  include Authifer::AuthenticationHelper
  include Authifer::Paths
end

get '/' do
  if logged_in?
    "<a href='#{ delete_session_path }'>log out</a>"
  else
    "<a href='#{ new_session_path }'>log in</a>" +
    " or " +
    "<a href='#{ new_user_path }'>register</a>"
  end
end
```

### If you need custom views:
Set the Authifer.views\_path before you load the database.

```ruby
Authifer.views_path = File.join(File.path(File.expand_path(__FILE__)),'views', 'authifer')
Authifer.connect_to_database('sqlite3://db/auth_provder.sqlite3')
```

Check out these [sample views](./lib/authifer/views).

## Contributing

We love pull requests and issues!

### For enhancements

Create an issue or pull request with:

1. A good name
2. Tests where applicable
3. 

### For bug fixes

Create an issue with:

1. Reproduction steps
2. Stack trace if applicable
3. Proposed fix if applicable

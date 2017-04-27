# mastodon

[![Build Status](https://travis-ci.org/decors/mastodon.cr.svg?branch=master)](https://travis-ci.org/decors/mastodon.cr)

A Crystal-lang library for [Mastodon](https://github.com/tootsuite/mastodon/) API

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  mastodon:
    github: decors/mastodon.cr
```

## Usage

```crystal
require "mastodon"
```

### Regist application & Authenticate

```crystal
client = Mastodon::REST::Client.new(url: "example.com")
app =  client.apps("My Mastodon App", scopes: "read write follow")

token = client.get_access_token_using_username_password(
  client_id: app.client_id,
  client_secret: app.client_secret,
  scopes: "read write follow",
  username: "USERNAME",
  password: "PASSWORD"
)

client.authenticate(token)
```

### Client

```crystal
client = Mastodon::REST::Client.new(url: "example.com", access_token: "ACCESS_TOKEN")
```

## Todo

* OAuth : scope handling

## Contributing

1. Fork it ( https://github.com/decors/mastodon.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Decors](https://github.com/decors)  - creator, maintainer

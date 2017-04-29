# Authenticate Account

Get access token

```crystal
client = Mastodon::REST::Client.new(url: "example.com")

token = client.get_access_token_using_username_password(
  client_id: "CLIENT_ID",         # Registered application's client ID
  client_secret: "CLIENT_SECRET", # Registered application's client secret
  scopes: "read write follow",    # Scope (space separated string)
  username: "USERNAME",           # Mastodon account's e-mail
  password: "PASSWORD"            # Mastodon account's password
) # => OAuth2::AccessToken::Bearer

client.authenticate(token)
```

Or if you already have a access token

```crystal
client = Mastodon::REST::Client.new(url: "example.com", access_token: "ACCESS_TOKEN")
```

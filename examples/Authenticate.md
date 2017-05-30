# Authenticate Account

# Get access token with password

```crystal
client = Mastodon::REST::Client.new(url: "example.com")

token = client.get_access_token_using_username_password(
  client_id: "CLIENT_ID",
  client_secret: "CLIENT_SECRET",
  scopes: "read write follow",    # Scope (space separated string)
  username: "USERNAME",           # Mastodon account's username (e-mail address)
  password: "PASSWORD"            # Mastodon account's password
) # => OAuth2::AccessToken::Bearer

client.authenticate(token)
```

# Get access token with authorization code

```crystal
client = Mastodon::REST::Client.new(url: "example.com")

url = client.authorize_uri(
  client_id: "CLIENT_ID",
  scopes: "read write follow",    # Scope (space separated string)
)

puts url # Authorization URL
```

```crystal
token = client.get_access_token_using_authorization_code(
  client_id: "CLIENT_ID",
  client_secret: "CLIENT_SECRET",
  scopes: "read write follow",    # Scope (space separated string)
  code: "AUTHORIZATION_CODE"      # Received authorization code
) # => OAuth2::AccessToken::Bearer

client.authenticate(token)
```

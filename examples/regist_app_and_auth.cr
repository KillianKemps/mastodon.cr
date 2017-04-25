require "../src/mastodon"

client = Mastodon::REST::Client.new(url: "example.com")
app =  client.apps("My Mastodon App", scopes: "read write follow")

token = client.get_access_token_using_username_password(
  client_id: app.client_id,
  client_secret: app.client_secret,
  scopes: "read write follow",
  username: "USERNAME",
  password: "PASSWORD"
)

client.authenticate(token.access_token)

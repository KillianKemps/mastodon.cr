# Regist Application

```crystal
client = Mastodon::REST::Client.new(url: "example.com")

app = client.apps(
  "My Mastodon App",           # Application name
  scopes: "read write follow", # Scope (space separated string)
  website: ""                  # Website URL (optional)
)

app.id            # => Application ID
app.client_id     # => Application client ID
app.client_secret # => Application client secret
```

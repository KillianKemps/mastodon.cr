require "../src/mastodon"

client = Mastodon::REST::Client.new(url: "example.com", access_token: "ACCESS_TOKEN")

# Post (Toot)
status = client.create_status("Toot") # => Mastodon::Entities::Status

# Delete
client.delete_status(status.id)

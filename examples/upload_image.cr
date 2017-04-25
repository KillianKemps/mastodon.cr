require "../src/mastodon"

client = Mastodon::REST::Client.new(url: "example.com", access_token: "ACCESS_TOKEN")

client.media_upload("examples/image.png") # => Mastodon::Entities::Attachment

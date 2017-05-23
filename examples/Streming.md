# Regist Application

## Authorized user's home timelines stream

```crystal
client = Mastodon::Streaming::Client.new(url: "example.com", access_token: "ACCESS_TOKEN")
client.user do |object|
  case object
  when Mastodon::Entities::Status
    puts object.content
  when Mastodon::Entities::Notification
    puts object.type
  end
end
```

## Public timelines stream

```crystal
client = Mastodon::Streaming::Client.new(url: "example.com", access_token: "ACCESS_TOKEN")
client.public do |status|
  status.content
end
```


## Public timelines for a hashtag stream

```crystal
client = Mastodon::Streaming::Client.new(url: "example.com", access_token: "ACCESS_TOKEN")
client.hashtag("HASHTAG") do |status|
  status.content
end
```

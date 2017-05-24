# Streaming

## Initialize client

```crystal
client = Mastodon::Streaming::Client.new(url: "example.com", access_token: "ACCESS_TOKEN")
```

## Use blocks

Authorized user's home timelines stream

```crystal
client.user do |object|
  case object
  when Mastodon::Entities::Status
    puts object.content
  when Mastodon::Entities::Notification
    puts object.type
  when Int32
    puts object
  end
end
```

Public timelines stream

```crystal
client.public do |object|
  case object
  when Mastodon::Entities::Status
    puts object.content
  when Int32
    puts object
  end
end
```

Public timelines for a hashtag stream

```crystal
client.hashtag("HASHTAG") do |object|
  case object
  when Mastodon::Entities::Status
    puts object.content
  when Int32
    puts object
  end
end
```

## Use callbacks

```crystal
client.on_update do |status|
  # status => Mastodon::Entities::Status
  puts status
end

client.on_notification do |notification|
  # notification => Mastodon::Entities::Notification
  puts notification
end

client.on_delete do |id|
  # id => Integer
  puts id
end

client.public
```

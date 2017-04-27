# Regist Application

## Authorized user's home timelines stream

```crystal
client.streaming_home do |object|
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
client.streaming_public do |status|
  status.content
end
```


## Public timelines for a hashtag stream

```crystal
client.streaming_tag("HASHTAG") do |status|
  status.content
end
```

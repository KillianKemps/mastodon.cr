# Toot

Toot

```crystal
client.create_status("Toot!!") # => Mastodon::Entities::Status
```

Reply

```crystal
client.create_status("Hello!!", in_reply_to_id: 1111111) # => Mastodon::Entities::Status
```

Spoiler

```crystal
client.create_status("Toot!!", spoiler_text: "SPOILER") # => Mastodon::Entities::Status
```

Toot visibility

```crystal
client.create_status("Toot!!", visibility: "private") # => Mastodon::Entities::Status
```

Attach media

```crystal
client.create_status("Toot!!", media_ids: [1111111]) # => Mastodon::Entities::Status
```

Delete toot

```crystal
client.delete_status(1111111)
```

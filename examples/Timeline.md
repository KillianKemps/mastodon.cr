# Timeline

```crystal
# Public timeline
client.timeline_public.each do |status|
  # status => Mastodon::Entities::Status
  puts status.content
end
```

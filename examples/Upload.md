# Upload Image

* Mastodon supports
  * image/jpeg, image/png, image/gif
  * video/webm, video/mp4

```crystal
# Upload
media = client.media_upload("examples/image.png") # => Mastodon::Entities::Attachment
```

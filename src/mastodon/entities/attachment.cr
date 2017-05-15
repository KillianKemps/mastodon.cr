require "json"

module Mastodon
  module Entities
    class Attachment

      JSON.mapping({
        id: Int32,
        type: String, # "image", "video", "gifv"
        url: String,
        remote_url: { type: String, nilable: true },
        preview_url: String,
        text_url: { type: String, nilable: true },
      })

      def_equals id
    end
  end
end

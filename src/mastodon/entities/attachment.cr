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
        meta: { type: Hash(String, Attachment::MetaData), nilable: true },
      })

      def_equals id

      class MetaData

        JSON.mapping({
          width: Int32,
          height: Int32,
          size: String,
          aspect: Float32,
        })

      end
    end
  end
end

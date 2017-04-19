require "json"

module Mastodon
  module Response
    class Attachment

      JSON.mapping({
        id: Int32,
        type: String,
        url: String,
        remote_url: { type: String, nilable: true },
        preview_url: { type: String, nilable: true },
        text_url: { type: String, nilable: true },
      })

      def_equals id
    end
  end
end

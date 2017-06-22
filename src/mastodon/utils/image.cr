require "base64"

module Mastodon
  module Utils
    module Image
      extend self

      def mime_type(finename)
        case File.extname(finename)
        when ".png"
          "image/png"
        when ".jpg", ".jpeg"
          "image/jpeg"
        when ".gif"
          "image/gif"
        else
          nil
        end
      end

    end
  end
end

require "http/client"
require "json"

module Mastodon
  module REST
    module Media
      private MEDIA_BASE = "/api/v1/media"

      def media_upload(filename)
        # image/jpeg, image/png, image/gif
        # video/webm, video/mp4
        raise ArgumentError.new("File not found") unless File.file?(filename)
        File.open(filename, "rb") do |file|
          form_data = Utils::MultipartFormData.new
          form_data.add_file("file", File.basename(filename), file)
          form_data.finish
          response = post_formdata("#{MEDIA_BASE}", form_data)
          Entities.from_response(response, Entities::Attachment)
        end
      end
    end
  end
end

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
          form_data = Utils::MultipartFormData.new("file", File.basename(filename), file)
          headers = HTTP::Headers{
            "Content-Length" => "#{form_data.size}",
            "Content-Type" => "#{form_data.content_type}",
            "User-Agent" => "#{@user_agent}"
          }
          response = @http_client.post("#{MEDIA_BASE}", headers, form_data.io.to_slice)
          body = proccess_response(response)
          Entities::Attachment.from_json(body)
        end
      end
    end
  end
end

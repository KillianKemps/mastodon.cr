require "http/client"

module Mastodon
  module REST
    class Error < Exception
      def initialize(response : HTTP::Client::Response)
        case response.content_type
          when "application/json"
            error = Entities::Error.from_json(response.body)
            super("#{response.status_code} #{error.error}")
          else
            super("#{response.status_code} #{response.status_message}")
        end
      end

      def initialize(message)
        super(message)
      end
    end
  end
end
